// Supabase edge function: BlueSpeak's AI speaking coach. The Gemini key is a server
// secret and never reaches the app:
//   supabase secrets set GEMINI_API_KEY=...        (optional: GEMINI_MODEL=...)
import { handleRequest } from "./handler.ts";

Deno.serve((req: Request) =>
  handleRequest(req, {
    apiKey: Deno.env.get("GEMINI_API_KEY"),
    model: Deno.env.get("GEMINI_MODEL"),
  })
);
