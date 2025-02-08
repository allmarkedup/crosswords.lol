import "./icons";

import Alpine from "alpinejs";
import focus from "@alpinejs/focus";
import persist from "@alpinejs/persist";

import state from "./state";

import { crossword, crosswordCell } from "./components/crossword";
import { puzzle } from "./components/puzzle";
import { actionbarButton } from "./components/actionbar_button";
import { timer } from "./components/timer";

window.Alpine = Alpine;

Alpine.plugin(focus);
Alpine.plugin(persist);

Alpine.store("state", state(Alpine));

Alpine.data("crossword", crossword);
Alpine.data("crosswordCell", crosswordCell);
Alpine.data("puzzle", puzzle);
Alpine.data("actionbarButton", actionbarButton);
Alpine.data("timer", timer);

Alpine.start();
