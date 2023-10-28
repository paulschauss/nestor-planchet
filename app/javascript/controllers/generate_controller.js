import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["input"];

  generate() {
    this.inputTarget.value = "toto";
  }
}