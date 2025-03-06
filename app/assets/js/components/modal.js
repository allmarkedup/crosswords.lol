export default function Modal() {
  return {
    id: null,
    ready: false,

    init() {
      this.id = this.$el.id;
      this.ready = true;
    },

    show() {
      this.$app.modal = this.id;
    },

    hide() {
      this.$app.modal = null;
    },
  };
}
