import { Controller } from "stimulus";

export default class extends Controller {
  static values = {
    location: String,
    business: String,
    review: String
  }

  static targets = ["input"]

  connect() {
    console.log(this.locationValue);
    console.log(this.businessValue);
    console.log(this.reviewValue);
  }

  generate() {
    fetch('/generate_response', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector("meta[name='csrf-token']").content
      },
      body: JSON.stringify({ 
        location: this.locationValue,
        business: this.businessValue,
        review: this.reviewValue
      })
    })
    .then(response => response.json())
    .then(data => {
      console.log('Success:', data.response.Answer);
      this.inputTarget.value = data.response.Answer;
    })
    .catch(error => {
      console.error('Error:', error);
    });
  }
}