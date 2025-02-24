export default function Modal() {
  return {
    id: null,

    init() {
      this.id = this.$el.id;
    },

    show() {
      this.$app.modal = this.id;
    },

    hide() {
      this.$app.modal = null;
    },
  };
}
