// ==UserScript==
// @name         Register Table Ziggifier
// @namespace    http://tampermonkey.net/
// @version      2025-07-28
// @description  This userscript tries to catch register definition tables on the arm documentation and convert them into Zig code
// @author       xq
// @match        https://developer.arm.com/documentation/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=arm.com
// @grant        none
// ==/UserScript==

/**
 *
 * Try on:
 * - https://developer.arm.com/documentation/100235/0100/The-Cortex-M33-Peripherals/System-Control-Block/MemManage-Fault-Address-Register?lang=en
 * - https://developer.arm.com/documentation/dui0662/b/Cortex-M0--Peripherals/System-Control-Block/System-Control-Register?lang=en
 *
 */

(function() {
    'use strict';

    console.log("startup...");
    let pattern = /\[(\d+)(?::(\d+))?\]/;

    function process()
    {
        for(const table of document.querySelectorAll("table.c-table"))
        {
            console.log(table);
            let fields = [];
            for(const row of table.rows)
            {
                if(row.cells.length != 3) {
                    continue;
                }
                let cells = Array.from(row.cells).map(x => x.innerText);
                const match = pattern.exec(cells[0]);
                if(match == null) {
                    console.log("skip", cells);
                    continue;
                }
                let msb = Number(match[1]);
                let lsb = Number(match[2] || match[1]);

                fields.push({
                    lsb: lsb,
                    msb: msb,
                    name: cells[1],
                    func: cells[2],
                });

            }
            fields.sort((a,b) => a.lsb - b.lsb);
            var str = `packed struct(u${fields[fields.length-1].msb+1}) {\n`;
            for(const fld of fields) {
                let suffix = "";
                if(fld.name == "-") {
                    fld.name = `_reserved${fld.lsb}`;
                    suffix = " = 0";
                }
                let size = `${fld.msb}:${fld.lsb}`;
                if(fld.msb == fld.lsb) {
                    size = `${fld.msb}`;
                }

                str += "\n";

                let docs = fld.func.replaceAll("\n\n", "\n").split("\n");

                if(docs.length == 1) {
                    docs[0] = `[${size}] ` + docs[0];
                } else {
                    docs = [`[${size}]`].concat(docs);
                }

                for(const line of docs)
                {
                    str += `    /// ${line}\n`;
                }
                str += `    ${fld.name}: u${fld.msb - fld.lsb + 1}${suffix},\n`;
            }
            str += "}";
            console.log(fields);
            console.log(str);

            const codeblock = document.createElement("textarea");
            codeblock.value = str;
            codeblock.style.width = "100%";
            codeblock.style.fontFamily = "monospace";
            codeblock.style.fontSize = "smaller";
            codeblock.style.height = "20em";
            codeblock.style.resize = "vertical";

            const cell = document.createElement("TD");
            cell.setAttribute("colspan", 3);
            cell.appendChild(codeblock);

            const appendix = document.createElement("TR");
            appendix.appendChild(cell);

            const tbody = document.createElement("TBODY");
            tbody.appendChild(cell);

            table.appendChild(tbody);

        }
    }

    setTimeout( process, 1000);

})();