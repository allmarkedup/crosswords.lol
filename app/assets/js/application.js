import "./icons";

import Alpine from "alpinejs";
import focus from "@alpinejs/focus";
import persist from "@alpinejs/persist";
import resize from "@alpinejs/resize";

import state from "./state";

import { app } from "./components/app";
import { settings } from "./components/settings";
import { crossword, crosswordCell } from "./components/crossword";
import { puzzle } from "./components/puzzle";
import { keyboardAction } from "./components/keyboard_action";
import { timer } from "./components/timer";
import { keyboard } from "./components/keyboard";

window.Alpine = Alpine;

Alpine.plugin(focus);
Alpine.plugin(persist);
Alpine.plugin(resize);

Alpine.store("state", state(Alpine));

Alpine.data("app", app);
Alpine.data("settings", settings);
Alpine.data("crossword", crossword);
Alpine.data("crosswordCell", crosswordCell);
Alpine.data("puzzle", puzzle);
Alpine.data("keyboardAction", keyboardAction);
Alpine.data("timer", timer);
Alpine.data("keyboard", keyboard);

Alpine.start();
