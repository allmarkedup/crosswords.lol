import { fetchHTML } from "../helpers/requests";
import { loadIcons } from "../helpers/icons";

const settings = {
  timer: false,
  stats: false,
};

const state = {
  crosswords: {},
};

export default function App() {
  return {
    $app: null,
    $settings: Alpine.$persist(settings).as("settings"),
    $state: Alpine.$persist(state).as("state"),
    loading: false,

    _focusWatcher: null,
    _morphRoot: null,

    hasFocus: true,
    screen: "puzzle",

    init() {
      this.$app = this;
      this._morphRoot = this.$el.querySelector("[data-morph-root]");
      this._focusWatcher = setInterval(() => {
        this.hasFocus = document.hasFocus();
      }, 200);

      loadIcons();
    },

    async hijax({ target }) {
      const link = target.hasAttribute("href") ? target : target.closest("[href]");
      return this.loadPage(link.href, true);
    },

    async loadPage(url, updateHistory = false) {
      this.loading = true;
      const { ok, doc } = await fetchHTML(url);
      if (ok) {
        this._morphRoot.innerHTML = doc.querySelector("[data-morph-root]").innerHTML;
        loadIcons();

        if (updateHistory) history.pushState({}, "", url);
      } else {
        console.error("Could not fetch page content", response);
        window.location = url;
      }
      this.loading = false;
    },

    destroy() {
      clearInterval(this._focusWatcher);
    },

    get morphRoot() {
      return this.$root.querySelector("[data-morph-root]");
    },
  };
}
