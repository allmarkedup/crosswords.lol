async function fetchHTML(url, options = {}) {
  const response = await fetch(url || location, options);
  const { status, ok } = response;
  const result = { ok, status, response, doc: null, url: response.url };
  if (status < 500) {
    const html = await response.text();
    result.doc = new DOMParser().parseFromString(html, "text/html");
  }
  return result;
}

export { fetchHTML };
