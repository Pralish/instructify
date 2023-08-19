// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"

window.formDataToJson = function formDataToJson(formData) {
  const jsonData = {};

  formData.forEach((value, key) => {
    const keys = key.split("[");
    let currentObj = jsonData;

    keys.forEach((keyPart, index) => {
      const keyName = keyPart.replace(/\]$/, "");
      if (!currentObj[keyName]) {
        currentObj[keyName] = {};
      }

      if (index === keys.length - 1) {
        currentObj[keyName] = value;
      }

      currentObj = currentObj[keyName];
    });
  });

  return jsonData;
}