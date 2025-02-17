const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");
const { exec } = require("child_process");
const fs = require("fs");
const path = require("path");

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(bodyParser.json());

// Endpoint para gerar diagramas Mermaid
app.post("/render", (req, res) => {
    console.log("Dados recebidos no body:", req.body);

    const mermaidCode = req.body.mermaidCode;
    if (!mermaidCode || mermaidCode.length < 5) {
        console.error("Erro: Código Mermaid inválido ou muito curto:", mermaidCode);
        return res.status(400).json({ error: "O código Mermaid é inválido ou muito curto." });
    }

    console.log("Código Mermaid recebido corretamente:", mermaidCode);

    const inputFile = path.join(__dirname, "temp.mmd");
    const outputFile = path.join(__dirname, "diagram.png");

    fs.writeFileSync(inputFile, mermaidCode);

    // Utiliza o caminho absoluto para o executável do mmdc
    const mmdcPath = path.join(__dirname, "node_modules", ".bin", "mmdc");

    exec(`${mmdcPath} -i ${inputFile} -o ${outputFile}`, (error, stdout, stderr) => {
        if (error) {
            console.error("Erro ao gerar diagrama:", stderr);
            return res.status(500).json({ error: `Erro ao gerar diagrama: ${stderr}` });
        }

        console.log("Diagrama gerado com sucesso!");
        res.sendFile(outputFile, () => {
            fs.unlinkSync(inputFile);
            fs.unlinkSync(outputFile);
        });
    });
});

app.listen(PORT, () => {
    console.log(`Servidor rodando em http://localhost:${PORT}`);
});
