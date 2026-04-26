
/**
 * Normalize the string to be readable for the inputs
 * @param {string} str 
 * @returns formatted type of the input value
 */
export let convertStrings = (str) => {
    return str.normalize("NFD")
              .replace(/[\u0300-\u036f]/g, "")
              .replaceAll(" ", "_")
              .toLowerCase();
  };