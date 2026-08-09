// Proxy /gym-coach → Azure OpenAI.
// La API key de Azure OpenAI vive en las variables de entorno (App Settings),
// NUNCA en el front-end. El sitio público solo habla con esta función.
module.exports = async function (context, req) {
  const ALLOWED_ORIGIN = process.env.ALLOWED_ORIGIN || "https://linismol.github.io";
  const cors = {
    "Access-Control-Allow-Origin": ALLOWED_ORIGIN,
    "Access-Control-Allow-Methods": "POST, OPTIONS",
    "Access-Control-Allow-Headers": "Content-Type",
  };

  // Preflight CORS
  if (req.method === "OPTIONS") {
    context.res = { status: 204, headers: cors };
    return;
  }

  const prompt = req.body && req.body.prompt;
  if (!prompt || typeof prompt !== "string") {
    context.res = { status: 400, headers: cors, body: { error: "Falta 'prompt' (string) en el body." } };
    return;
  }
  // Límite defensivo de longitud del prompt (evita abuso de un endpoint público)
  if (prompt.length > 8000) {
    context.res = { status: 413, headers: cors, body: { error: "Prompt demasiado largo." } };
    return;
  }

  try {
    const endpoint = (process.env.AOAI_ENDPOINT || "").replace(/\/+$/, "");
    const deployment = process.env.AOAI_DEPLOYMENT;
    const apiVersion = process.env.AOAI_API_VERSION || "2024-10-21";
    const url = `${endpoint}/openai/deployments/${deployment}/chat/completions?api-version=${apiVersion}`;

    const r = await fetch(url, {
      method: "POST",
      headers: { "api-key": process.env.AOAI_KEY, "Content-Type": "application/json" },
      body: JSON.stringify({
        messages: [{ role: "user", content: prompt }],
        max_tokens: 500,
        temperature: 0.7,
      }),
    });

    if (!r.ok) {
      const detail = await r.text();
      context.log.error("Azure OpenAI error", r.status, detail);
      context.res = { status: 502, headers: cors, body: { error: "Error del modelo (" + r.status + ")." } };
      return;
    }

    const data = await r.json();
    const text = data.choices && data.choices[0] && data.choices[0].message
      ? data.choices[0].message.content : "";
    context.res = { status: 200, headers: cors, body: { text } };
  } catch (e) {
    context.log.error(e);
    context.res = { status: 500, headers: cors, body: { error: "Error interno del proxy." } };
  }
};
