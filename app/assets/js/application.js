import "container-query-polyfill";

import Alpine from "alpinejs";
import focus from "@alpinejs/focus";
import persist from "@alpinejs/persist";
import resize from "@alpinejs/resize";

import App from "./components/app";
import Button from "./components/button";
import Crossword from "./components/crossword";
import CrosswordCell from "./components/crossword_cell";
import Icon from "./components/icon";
import Keyboard from "./components/keyboard";
import Puzzle from "./components/puzzle";
import Timer from "./components/timer";

Alpine.plugin(focus);
Alpine.plugin(persist);
Alpine.plugin(resize);

Alpine.data("app", App);
Alpine.data("button", Button);
Alpine.data("crossword", Crossword);
Alpine.data("crosswordCell", CrosswordCell);
Alpine.data("icon", Icon);
Alpine.data("keyboard", Keyboard);
Alpine.data("puzzle", Puzzle);
Alpine.data("timer", Timer);

window.Alpine = Alpine;
Alpine.start();
