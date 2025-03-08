import "container-query-polyfill";

import Alpine from "alpinejs";
import focus from "@alpinejs/focus";
import persist from "@alpinejs/persist";
import morph from "@alpinejs/morph";

import AnswerData from "./components/answer_data";
import App from "./components/app";
import Button from "./components/button";
import Crossword from "./components/crossword";
import CrosswordCell from "./components/crossword_cell";
import Keyboard from "./components/keyboard";
import LoadingBar from "./components/loading_bar";
import Modal from "./components/modal";
import Puzzle from "./components/puzzle";
import Stats from "./components/stats";
import Timer from "./components/timer";

Alpine.plugin(focus);
Alpine.plugin(persist);
Alpine.plugin(morph);

Alpine.data("answerData", AnswerData);
Alpine.data("app", App);
Alpine.data("button", Button);
Alpine.data("crossword", Crossword);
Alpine.data("crosswordCell", CrosswordCell);
Alpine.data("keyboard", Keyboard);
Alpine.data("loadingBar", LoadingBar);
Alpine.data("modal", Modal);
Alpine.data("puzzle", Puzzle);
Alpine.data("stats", Stats);
Alpine.data("timer", Timer);

window.Alpine = Alpine;
Alpine.start();
