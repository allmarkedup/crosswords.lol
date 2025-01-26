import Alpine from "alpinejs";
import focus from "@alpinejs/focus";
import persist from "@alpinejs/persist";

import { crossword, crosswordCell } from "./components/crossword";
import { puzzle } from "./components/puzzle";

window.Alpine = Alpine;

Alpine.plugin(focus);
Alpine.plugin(persist);

Alpine.store("state", {
  crosswords: Alpine.$persist({}).as("crosswords-state"),
});

Alpine.data("crossword", crossword);
Alpine.data("crosswordCell", crosswordCell);
Alpine.data("puzzle", puzzle);

Alpine.start();
