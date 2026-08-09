# /gym-coach backend — Azure OpenAI proxy

Pequeña Azure Function que recibe un `prompt` desde la app pública y responde con
texto del modelo. La **API key de Azure OpenAI vive en las App Settings de la Function**,
nunca en el front-end.

```
app (github.io) ──POST {prompt}──► Azure Function (guarda la key) ──► Azure OpenAI ──► texto
```

## Nombres de este proyecto
| Recurso | Nombre |
|---|---|
| Resource group | `LinisGymApp` |
| Proyecto en Azure AI Foundry | `gymapp` |
| Deployment del modelo | `gpt-4.1-mini` |
| Function App | `linis-coach-fn` (debe ser único; ajusta si está tomado) |
| Origen permitido (CORS) | `https://linismol.github.io` |

---

## PARTE A — Crear el modelo (Azure OpenAI + Foundry)

1. [portal.azure.com](https://portal.azure.com) → **Create a resource** → **"Azure OpenAI"** → **Create**.
2. **Subscription:** la tuya · **Resource group:** *Create new* → **`LinisGymApp`** · **Region:** `East US 2` o `Sweden Central` · **Name:** `linis-openai` · **Pricing tier:** `Standard S0` → **Review + create** → **Create**.
3. Abre el recurso → **"Go to Azure AI Foundry portal"**.
4. En Foundry, si pide/permite crear proyecto, nómbralo **`gymapp`** (bajo el resource group `LinisGymApp`).
5. Menú **Deployments** → **Deploy model** → **Deploy base model** → **`gpt-4.1-mini`** → **Deployment name:** `gpt-4.1-mini` → **Deploy**.
   - Si `gpt-4.1-mini` no aparece en tu región, usa `gpt-4o-mini` o cambia de región.
6. Vuelve al recurso en el portal → **Keys and Endpoint** → copia:
   - **Endpoint** (ej. `https://linis-openai.openai.azure.com/`)
   - **KEY 1**

## PARTE B — Crear el proxy (Function App)

7. Portal → **Create a resource** → **"Function App"** → **Create** → tipo **Consumption**.
8. **Basics:**
   - **Resource group:** **`LinisGymApp`** · **Name:** `linis-coach-fn`
   - **Runtime stack:** `Node.js` · **Version:** `20 LTS`
   - ⚠️ **Operating System:** `Windows` (permite pegar el código en el portal)
   - **Region:** la misma → **Review + create** → **Create**.
9. Abre la Function App → **Settings → Environment variables** → agrega y **Apply/Save**:

   | Name | Value |
   |---|---|
   | `AOAI_ENDPOINT` | tu Endpoint del paso 6 |
   | `AOAI_KEY` | tu KEY 1 del paso 6 |
   | `AOAI_DEPLOYMENT` | `gpt-4.1-mini` |
   | `AOAI_API_VERSION` | `2025-01-01-preview` *(recomendado para gpt-4.1)* |

10. **CORS:** no lo configures en el portal — la función **ya devuelve los headers de CORS** ella misma. Déjalo **vacío** (si configuras CORS en el portal *y* en el código, salen headers duplicados y el navegador falla).
11. Menú **Functions** → **+ Create** → **HTTP trigger** → nombre `coach` → **Create**.
12. Función `coach` → **Code + Test**:
    - `index.js` → pega [`coach/index.js`](coach/index.js) → **Save**.
    - `function.json` → pega [`coach/function.json`](coach/function.json) → **Save**.
13. **Get Function URL** → copia la URL (`https://linis-coach-fn.azurewebsites.net/api/coach?code=...`).

## PARTE B (alternativa) — Flex Consumption (Linux) + GitHub Actions

Si el plan **Consumption** clásico te da problemas al crear la Function App, usa **Flex Consumption**
(Linux, también escala a cero y ~$0 para uso personal). En Flex **no se pega el código en el portal**;
se despliega por paquete, y como el código ya está en el repo, lo hace **GitHub Actions** solo.

- **B1.** Crea la Function App → hosting **Flex Consumption** · RG `LinisGymApp` · Runtime **Node 20** · misma región.
- **B2.** Igual que en Parte B: agrega las **Environment variables** (`AOAI_ENDPOINT`, `AOAI_KEY`, `AOAI_DEPLOYMENT`, `AOAI_API_VERSION`). CORS: **vacío** (la función lo maneja).
- **B3.** Function App → **Deployment / Overview** → **Get publish profile** (descarga un archivo `.PublishSettings`).
- **B4.** En GitHub (repo `linismol/linis-gym-app`) → **Settings → Secrets and variables → Actions → New repository secret**:
  - **Name:** `AZURE_FUNCTIONAPP_PUBLISH_PROFILE`
  - **Value:** pega **todo** el contenido del archivo descargado.
- **B5.** Si tu Function App **no** se llama `linis-coach-fn`, edita `app-name` en [`.github/workflows/deploy-coach.yml`](../.github/workflows/deploy-coach.yml).
- **B6.** Dispara el deploy: pestaña **Actions** → *"Deploy /gym-coach function"* → **Run workflow** (o haz un push que toque `azure-coach/`).
- **B7.** Al terminar (verde en Actions): Function App → función `coach` → **Get Function URL**.

## PARTE C — Conectar la app
14. Pasa esa URL a Claude y se conecta en el `index.html` en vivo → chat + análisis funcionando en la URL pública.

---

## Variables de entorno (referencia)
| Nombre | Ejemplo | Qué es |
|---|---|---|
| `AOAI_ENDPOINT` | `https://linis-openai.openai.azure.com/` | Endpoint del recurso Azure OpenAI |
| `AOAI_KEY` | `xxxxxxxx...` | KEY 1 del recurso Azure OpenAI |
| `AOAI_DEPLOYMENT` | `gpt-4.1-mini` | Nombre del *deployment* del modelo |
| `AOAI_API_VERSION` | `2025-01-01-preview` | (opcional) versión de API |
| `ALLOWED_ORIGIN` | `https://linismol.github.io` | (opcional) origen permitido por CORS |

## Archivos
- `coach/index.js` — la función (modelo clásico; se pega en el editor del portal).
- `coach/function.json` — trigger HTTP (POST/OPTIONS).
- `host.json` — configuración base.

## Nota de seguridad (endpoint público)
La app es pública y sin login, así que la URL de la función es visible para quien mire el
código. La key de Azure OpenAI sigue protegida (solo la ve la función), pero alguien podría
llamar el proxy y gastar créditos. Mitigaciones ya incluidas / recomendadas:
- `max_tokens` bajo (500) y límite de longitud del prompt.
- Poner un **límite de TPM/cuota** en el deployment `gpt-4.1-mini` (Foundry → Deployments → Edit) — topa el gasto.
- Dejar `authLevel: function` (la URL lleva `?code=...`) como ofuscación leve.
- Opcional: rotar la function key o añadir un secreto compartido si ves abuso.
