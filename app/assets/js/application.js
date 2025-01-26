import Alpine from "alpinejs";
import focus from "@alpinejs/focus";

import { crossword, crosswordCell } from "./components/crossword";
import { puzzle } from "./components/puzzle";

window.Alpine = Alpine;

Alpine.plugin(focus);

Alpine.data("crossword", crossword);
Alpine.data("crosswordCell", crosswordCell);
Alpine.data("puzzle", puzzle);

Alpine.start();
