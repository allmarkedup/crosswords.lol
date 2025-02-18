export function timerText(seconds) {
  const elapsed = seconds * 1000;
  let h = "00",
    m = "00",
    s = "00";

  if (elapsed >= 1000) {
    s = Math.floor(elapsed / 1000);
    s = s > 60 ? s % 60 : s;
    s = leftPad(s);
  }

  if (elapsed > 60000) {
    m = Math.floor(elapsed / 60000);
    m = m > 60 ? m % 60 : leftPad(m);
  }

  if (elapsed > 3600000) {
    h = Math.floor(elapsed / 3600000);
    h = leftPad(h);
  }

  return [h, m, s].join(":");
}

function leftPad(val) {
  return val < 10 ? "0" + String(val) : val;
}
