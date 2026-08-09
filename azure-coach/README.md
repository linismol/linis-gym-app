# /gym-coach backend — Azure OpenAI proxy

Pequeña Azure Function que recibe un `prompt` desde la app pública y responde con
texto del modelo. La **API key de Azure OpenAI vive en las App Settings de la Function**,
nunca en el front-end.

```
app (github.io) ──POST {prompt}──► Azure Function (guarda la key) ──► Azure OpenAI ──► texto
```

## Variables de entorno (App Settings de la Function)
| Nombre | Ejemplo | Qué es |
|---|---|---|
| `AOAI_ENDPOINT` | `https://linis-openai.openai.azure.com/` | Endpoint del recurso Azure OpenAI |
| `AOAI_KEY` | `xxxxxxxx...` | KEY 1 del recurso Azure OpenAI |
| `AOAI_DEPLOYMENT` | `gpt-4o-mini` | Nombre del *deployment* del modelo |
| `AOAI_API_VERSION` | `2024-10-21` | (opcional) versión de API |
| `ALLOWED_ORIGIN` | `https://linismol.github.io` | (opcional) origen permitido por CORS |

## Archivos
- `coach/index.js` — la función (modelo clásico; se puede pegar en el editor del portal).
- `coach/function.json` — trigger HTTP (POST/OPTIONS).
- `host.json` — configuración base.

## Nota de seguridad (endpoint público)
Como la app es pública y sin login, la URL de la función es visible para quien mire el
código. La key de Azure OpenAI sigue protegida (solo la ve la función), pero alguien podría
llamar el proxy y gastar créditos. Mitigaciones ya incluidas / recomendadas:
- `max_tokens` bajo (500) y límite de longitud del prompt.
- Poner un **límite de TPM/cuota** en el deployment de Azure OpenAI (bloquea el gasto).
- Dejar `authLevel: function` (la URL lleva un `?code=...`) como ofuscación leve.
- Opcional: rotar la function key o añadir un secreto compartido si ves abuso.
