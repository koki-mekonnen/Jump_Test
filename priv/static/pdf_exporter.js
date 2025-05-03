const fs = require("fs");
const puppeteer = require("puppeteer");

(async () => {
    const html = fs.readFileSync("priv/static/export.html", "utf8");
    const browser = await puppeteer.launch();
    const page = await browser.newPage();

    await page.setContent(html, { waitUntil: "networkidle0" });
    await page.pdf({ path: "priv/static/export.pdf", format: "A4" });

    await browser.close();
})();
