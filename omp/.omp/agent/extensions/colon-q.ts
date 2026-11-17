// ~/.omp/agent/extensions/colon-q.ts
import type { ExtensionAPI } from "@oh-my-pi/pi-coding-agent";

export default function (pi: ExtensionAPI) {
   pi.on("input", (event, ctx) => {
      if (event.text.trim() !== ":q") return;
      ctx.shutdown();
      return { handled: true };
   });
}
