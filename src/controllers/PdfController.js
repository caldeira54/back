const IdentificationModel = require('../models/IdentificationModel');
const WeekModel = require('../models/WeekModel');
const ReferenceModel = require('../models/ReferenceModel');

const PDFDocument = require('pdfkit-table');

class PdfController {
    async generatePdf(req, res) {
        try {
            // Recupere o ID do usuário a partir dos parâmetros da solicitação
            const idIdentification = req.params.idIdentification;

            // Recupere dados das tabelas usando Sequelize, filtrando por ID de usuário
            const identifications = await IdentificationModel.findAll({
                where: { id: idIdentification }
            });

            // Crie um novo documento PDF
            const doc = new PDFDocument({size: 'A4'});

            // Configurar informações estáticas no cabeçalho
            doc.on('pageAdded', () => {
                const coatOfArms = 'C:/Users/calde/OneDrive/Documentos/sysPPT/frontend/src/assets/img/coatofarms.png';
                const imageWidth = 100; // Largura da imagem
                const pageWidth = doc.page.width;
                const xPosition = (pageWidth - imageWidth) / 2;
                doc.image(coatOfArms, xPosition, 10, { width: imageWidth });

                doc.font('Helvetica').fontSize(10);
                doc.text('MINISTÉRIO DA EDUCAÇÃO', 50, 30, { align: 'center' });
                doc.text('SECRETÁRIA DE EDUCAÇÃO PROFISSIONAL E TECNOLÓGICA', 50, 45, { align: 'center' });
                doc.text('INSTITUTO FEDERAL DE EDUCAÇÃO, CIÊNCIA E TECNOLOGIA DE MINAS GERAIS', 50, 60, { align: 'center' });
                doc.text('CAMPUS SÃO JOÃO EVANGELISTA', 50, 75, { align: 'center' });
                doc.text('Avenida Primeiro de Junho, nº. 1043, Bairro Centro, São João Evangelista, CEP 39705-000, Estado de Minas Gerais', 50, 90, { align: 'center' });
                doc.moveDown();
            });

            // Configurar o cabeçalho
            res.setHeader('Content-Type', 'application/pdf');
            res.setHeader('Content-Disposition', 'attachment; filename=relatorios.pdf');
            

            // Iterar sobre as identificações
            for (const identification of identifications) {
                // Adicione conteúdo ao PDF para cada identificação
                doc.addPage();
                // doc.fontSize(16).text(`Relatório de Dados - ${identification.discipline}`, { align: 'center' });
                doc.fontSize(16).text(`PLANO PEDAGÓGICO DE TRABALHO - PPT`, { align: 'center' });
                doc.moveDown();

                doc.fontSize(16).text('1.IDENTIFICAÇÃO:', { align: 'center' });
                doc.fontSize(12).text(`Disciplina: ${identification.discipline} | Carga Horária: ${identification.totalWorkload}`);
                doc.fontSize(12).text(`Professor: ${identification.teacher}`);
                doc.fontSize(12).text(`Ano: ${identification.year} | Série/Período: ${identification.period}`);
                doc.fontSize(12).text(`Curso: ${identification.course} | Turma: ${identification.team}`);
                // const identificationDetails = [
                //     `Disciplina: ${identification.discipline}`, { lineHeight: 2 },
                //     `Carga Horária: ${identification.totalWorkload}`,
                //     `Professor: ${identification.teacher}`,
                //     `Ano: ${identification.year}`,
                //     `Série/período: ${identification.period}`,
                //     `Curso: ${identification.course}`,
                //     `Turma: ${identification.team}`
                //     // Adicione mais tópicos conforme necessário
                // ];

                // doc.text(identificationDetails.join(' | '));

                const weeks = await WeekModel.findAll({ where: { idIdentification: identification.id } });
                const references = await ReferenceModel.findAll({ where: { idIdentification: identification.id } });

                // Adicione semanas e referências associadas a esta identificação
                doc.moveDown().fontSize(16).text('2.ORGANIZAÇÃO DIDÁTICA', { align: 'center' });

                doc.fontSize(12).text(`Ementa: ${identification.courseProgram}`);
                doc.fontSize(12).text(`Objetivo: ${identification.objective}`);

                weeks.forEach(w => {
                    const tableWeek = {
                        headers: ["Sequência Semanal", "Conteúdo Programático", "Metodologia", "Avaliação"],
                        rows: [

                            [`${w.startDate}`, `${w.programContent}`, `${w.methodology}`, `${w.assessment}`]

                            // ["Switzerland", "12%", "+1.12%"],
                            // ["France", "67%", "-0.98%"],
                            // ["England", "33%", "+4.44%"],
                        ],
                    };


                    //     const concatenatedDates = `${w.startDate} à ${w.endDate}`;
                    //     // const weeksTable = createTable(1, 4);
                    //     // weeksTable
                    //     //     .setHeaderRow(['Sequência Semanal', 'Conteúdo Programático', 'Metodologia', 'Avaliação'])
                    //     //     .addBody(weeks.map(w => [w.weekOrder, w.programContent, w.methodology, w.assessment]));

                    //     // doc.addTable(weeksTable);
                    //     doc.text(`Semana ${w.weekOrder} ${concatenatedDates}`);
                    //     doc.text(`Conteúdo ${w.programContent}`);
                    //     doc.text(`Metodologia ${w.methodology}`);
                    //     doc.text(`Avaliação ${w.assessment}`);
                    doc.table(tableWeek);
                });

                doc.moveDown().fontSize(16).text('3.REFERÊNCIAS', { align: 'center' });
                references.forEach(r => {
                    doc.fontSize(12).text(`Básicas: ${r.basic}`);
                    doc.fontSize(12).text(`Complementares: ${r.additional}`);
                });
            }
            doc.pipe(res);
            // Finalizar o documento PDF
            doc.end();
        } catch (error) {
            console.error('Erro ao gerar o PDF:', error);
            res.status(500).send('Erro ao gerar o PDF');
        }
    }
}

module.exports = new PdfController();