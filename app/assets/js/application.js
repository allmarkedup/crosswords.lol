import Alpine from "alpinejs";
import { crossword, crosswordCell } from "./components/crossword";
import { puzzle } from "./components/puzzle";

window.Alpine = Alpine;

Alpine.data("crossword", crossword);
Alpine.data("crosswordCell", crosswordCell);
Alpine.data("puzzle", puzzle);

Alpine.start();
