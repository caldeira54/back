-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ppt
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ppt
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ppt` DEFAULT CHARACTER SET utf8mb3 ;
USE `ppt` ;

-- -----------------------------------------------------
-- Table `ppt`.`holiday`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ppt`.`holiday` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `date` DATE NOT NULL,
  `createdAt` DATE NULL DEFAULT NULL,
  `updatedAt` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ppt`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ppt`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `active` TINYINT(1) NOT NULL DEFAULT '1',
  `createdAt` DATE NULL DEFAULT NULL,
  `updatedAt` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ppt`.`course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ppt`.`course` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `createdAt` DATE NULL,
  `updatedAt` DATE NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ppt`.`identification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ppt`.`identification` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idUser` INT NOT NULL,
  `idCourse` INT NOT NULL,
  `teacher` VARCHAR(255) NOT NULL,
  `course` VARCHAR(255) NOT NULL,
  `year` VARCHAR(4) NOT NULL,
  `team` VARCHAR(255) NOT NULL,
  `discipline` VARCHAR(255) NOT NULL,
  `totalWorkload` INT NOT NULL,
  `period` VARCHAR(255) NOT NULL,
  `courseProgram` VARCHAR(1000) NOT NULL,
  `objective` VARCHAR(1000) NOT NULL,
  `scope` VARCHAR(10) NOT NULL,
  `createdAt` DATE NULL DEFAULT NULL,
  `updatedAt` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_identification_user1_idx` (`idUser` ASC) VISIBLE,
  INDEX `fk_identification_course2_idx` (`idCourse` ASC) VISIBLE,
  CONSTRAINT `fk_identification_user1`
    FOREIGN KEY (`idUser`)
    REFERENCES `ppt`.`user` (`id`),
  CONSTRAINT `fk_identification_course2`
    FOREIGN KEY (`idCourse`)
    REFERENCES `ppt`.`course` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ppt`.`reference`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ppt`.`reference` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idIdentification` INT NOT NULL,
  `basic` VARCHAR(1000) NOT NULL,
  `additional` VARCHAR(1000) NOT NULL,
  `date` DATE NOT NULL,
  `createdAt` DATE NULL DEFAULT NULL,
  `updatedAt` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_reference_identification_idx` (`idIdentification` ASC) VISIBLE,
  CONSTRAINT `fk_reference_identification`
    FOREIGN KEY (`idIdentification`)
    REFERENCES `ppt`.`identification` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ppt`.`week`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ppt`.`week` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idIdentification` INT NOT NULL,
  `startDate` DATE NOT NULL,
  `endDate` DATE NOT NULL,
  `programContent` VARCHAR(1000) NULL DEFAULT NULL,
  `methodology` VARCHAR(1000) NULL DEFAULT NULL,
  `assessment` VARCHAR(1000) NULL DEFAULT NULL,
  `numberClasses` VARCHAR(45) NULL DEFAULT NULL,
  `numberOfDays` INT NULL DEFAULT NULL,
  `weekOrder` INT NULL DEFAULT NULL,
  `createdAt` DATE NULL DEFAULT NULL,
  `updatedAt` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_week_identification_idx` (`idIdentification` ASC) VISIBLE,
  CONSTRAINT `fk_week_identification`
    FOREIGN KEY (`idIdentification`)
    REFERENCES `ppt`.`identification` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ppt`.`weekholidays`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ppt`.`weekholidays` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `WeekId` INT NOT NULL,
  `HolidayId` INT NOT NULL,
  `createdAt` DATE NULL DEFAULT NULL,
  `updatedAt` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_weekholiday_week_idx` (`WeekId` ASC) VISIBLE,
  INDEX `fk_weekholiday_holiday_idx` (`HolidayId` ASC) VISIBLE,
  CONSTRAINT `fk_weekholiday_holiday`
    FOREIGN KEY (`HolidayId`)
    REFERENCES `ppt`.`holiday` (`id`),
  CONSTRAINT `fk_weekholiday_week`
    FOREIGN KEY (`WeekId`)
    REFERENCES `ppt`.`week` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ppt`.`discipline`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ppt`.`discipline` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idCourse` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `createdAt` DATE NULL,
  `updatedAt` DATE NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_discipline_course1_idx` (`idCourse` ASC) VISIBLE,
  CONSTRAINT `fk_discipline_course1`
    FOREIGN KEY (`idCourse`)
    REFERENCES `ppt`.`course` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO course(name, createdAt, updatedAt) VALUES ('Administração', '2023-12-11', '2023-12-11'), ('Agronomia', '2023-12-11', '2023-12-11'),
('Engenharia Florestal', '2023-12-11', '2023-12-11'), ('Sistemas de Informação', '2023-12-11', '2023-12-11'),
('Ciências Biologicas', '2023-12-11', '2023-12-11'), ('Matemática', '2023-12-11', '2023-12-11'),
('Técnico em Informática', '2023-12-11', '2023-12-11'), ('Técnico em Nutrição e Dietética', '2023-12-11', '2023-12-11'), 
('Técnico em Agropecuária', '2023-12-11', '2023-12-11'), ('Técnico em Agrimensura', '2023-12-11', '2023-12-11'),
('Especialização em Meio Ambiente', '2023-12-11', '2023-12-11'), ('Especialização em Ensino e Tecnologias Educacionais', '2023-12-11', '2023-12-11'),
('Especialização em Gestão', '2023-12-11', '2023-12-11');

-- -----------------------------------------------------
-- Sistemas de Informação
-- -----------------------------------------------------

INSERT INTO discipline(idCourse, name, createdAt, updatedAt) VALUES(4, 'Introdução a Programação', '2023-12-11', '2023-12-11'),
(4, 'Ética e Legislação', '2023-12-11', '2023-12-11'), (4, 'Introdução a Computação', '2023-12-11', '2023-12-11'), 
(4, 'Lógica Matemática', '2023-12-11', '2023-12-11'), (4, 'Português Instrumental', '2023-12-11', '2023-12-11'),
(4, 'Algoritmo e Estrutura de Dados I', '2023-12-11', '2023-12-11'), (4, 'Fundamentos de Matemática', '2023-12-11', '2023-12-11'),
(4, 'Fundamentos de Sistemas de Informação', '2023-12-11', '2023-12-11'), (4, 'Inglês Instrumental', '2023-12-11', '2023-12-11'), 
(4, 'Sociologia', '2023-12-11', '2023-12-11'), (4, 'Teorias da Administração', '2023-12-11', '2023-12-11'), 
(4, 'Álgebra Linear', '2023-12-11', '2023-12-11'), (4, 'Algortirmos e Estruturas de Dados II', '2023-12-11', '2023-12-11'), 
(4, 'Banco de Dados I', '2023-12-11', '2023-12-11'), (4, 'Cálculo Diferencial e Integral I', '2023-12-11', '2023-12-11'), 
(4, 'Gestão de Pessoas', '2023-12-11', '2023-12-11'), (4, 'Metodologia Científica', '2023-12-11', '2023-12-11'), 
(4, 'Algoritmos e Estrutura de Dados III', '2023-12-11', '2023-12-11'), (4, 'Banco de Dados II', '2023-12-11', '2023-12-11'), 
(4, 'Cálculo Diferencial e Integral II', '2023-12-11', '2023-12-11'), (4, 'Engenharia de Software I', '2023-12-11', '2023-12-11'), 
(4, 'Interface Usuário Máquina', '2023-12-11', '2023-12-11'), (4, 'Linguagem de Programação I', '2023-12-11', '2023-12-11'), 
(4, 'Redes de Computadores I', '2023-12-11', '2023-12-11'), (4, 'Contabilidade Básica', '2023-12-11', '2023-12-11'), 
(4, 'Engenharia de Software II', '2023-12-11', '2023-12-11'), (4, 'Linguagem de Programação II', '2023-12-11', '2023-12-11'), 
(4, 'Matemática Discreta', '2023-12-11', '2023-12-11'), (4, 'Redes de Computadores II', '2023-12-11', '2023-12-11'), 
(4, 'Sistemas Operacionais', '2023-12-11', '2023-12-11'), (4, 'Desenvolvimento WEB I', '2023-12-11', '2023-12-11'), 
(4, 'Estatística Básica', '2023-12-11', '2023-12-11'), (4, 'Gestão da Informação e do Conhecimento', '2023-12-11', '2023-12-11'), 
(4, 'Gestão de Processos', '2023-12-11', '2023-12-11'), (4, 'Pesquisa Operacional', '2023-12-11', '2023-12-11'), 
(4, 'Redes de Computadores III', '2023-12-11', '2023-12-11'), (4, 'Desenvolvimento WEB II', '2023-12-11', '2023-12-11'), 
(4, 'Empreendedorismo e Plano de Negócios', '2023-12-11', '2023-12-11'), (4, 'Gerência de Projetos', '2023-12-11', '2023-12-11'), 
(4, 'Inteligência Artificial', '2023-12-11', '2023-12-11'), (4, 'Trabalho de Conclusão de Curso I', '2023-12-11', '2023-12-11'), 
(4, 'Tecnologia e Sociedade', '2023-12-11', '2023-12-11'), (4, 'Multimídia', '2023-12-11', '2023-12-11'), 
(4, 'Segurança e Auditoria de Sistemas', '2023-12-11', '2023-12-11'), (4, 'Trabalho de Conclusão de Curso II', '2023-12-11', '2023-12-11'),
(4, 'Tópicos em Desenvolvimento Para Dispositivos Móveis', '2023-12-11', '2023-12-11'),
(4, 'Tópico em Mineração de Dados', '2023-12-11', '2023-12-11'), (4, 'Seminários', '2023-12-11', '2023-12-11'), 
(4, 'Tópicos Especiais em Desenvolvimento WEB', '2023-12-11', '2023-12-11'), (4, 'Introdução a Linguagem R', '2023-12-11', '2023-12-11');

-- -----------------------------------------------------
-- Administração
-- -----------------------------------------------------

INSERT discipline(idCourse, name, createdAt, updatedAt) VALUES(1, 'Teorias da Administração', '2023-12-11', '2023-12-11'),
(1, 'Empreendedorismo', '2023-12-11', '2023-12-11'), (1, 'Marketing', '2023-12-11', '2023-12-11'),
(1, 'Informática Aplicada', '2023-12-11', '2023-12-11'), (1, 'Fundamentos da Matemática', '2023-12-11', '2023-12-11'),
(1, 'Português Instrumental', '2023-12-11', '2023-12-11'), (1, 'Administração Rural', '2023-12-11', '2023-12-11'),
(1, 'Gestão de Pessoas', '2023-12-11', '2023-12-11'), (1, 'Legislação Trabalhista e Empresarial', '2023-12-11', '2023-12-11'),
(1, 'Cálculo I', '2023-12-11', '2023-12-11'), (1, 'Filosofia', '2023-12-11', '2023-12-11'),
(1, 'Comunicação Organizacional', '2023-12-11', '2023-12-11'), (1, 'Oficina de Produtos I Extensão', '2023-12-11', '2023-12-11'),
(1, 'Comportamento e Ética Organizacional', '2023-12-11', '2023-12-11'), (1, 'Estatística Básica', '2023-12-11', '2023-12-11'),
(1, 'Contabilidade Básica', '2023-12-11', '2023-12-11'), (1, 'Gestão de processos', '2023-12-11', '2023-12-11'),
(1, 'Matemática Financeira', '2023-12-11', '2023-12-11'), (1, 'Sociologia', '2023-12-11', '2023-12-11'),
(1, 'Oficina de Produtos II Extensão', '2023-12-11', '2023-12-11'), (1, 'Logística', '2023-12-11', '2023-12-11'),
(1, 'Métodos Quantitativos', '2023-12-11', '2023-12-11'), (1, 'Marketing Digital', '2023-12-11', '2023-12-11'),
(1, 'Gestão de Custos', '2023-12-11', '2023-12-11'), (1, 'Metodologia Científica I', '2023-12-11', '2023-12-11'),
(1, 'Fundamentos da Economia', '2023-12-11', '2023-12-11'), (1, 'Oficina de Produtos III Extensão', '2023-12-11', '2023-12-11'),
(1, 'Gestão da Cadeia de Suprimentos', '2023-12-11', '2023-12-11'), (1, 'Inovação e Criatividade', '2023-12-11', '2023-12-11'),
(1, 'Gestão Estratégica', '2023-12-11', '2023-12-11'), (1, 'Gestão da Qualidade', '2023-12-11', '2023-12-11'),
(1, 'Legislação Tributária', '2023-12-11', '2023-12-11'), (1, 'Pesquisa Operacional', '2023-12-11', '2023-12-11'),
(1, 'Oficina de Produtos IV Extensão', '2023-12-11', '2023-12-11'), (1, 'Gestão da Produção', '2023-12-11', '2023-12-11'),
(1, 'Gestão Financeira', '2023-12-11', '2023-12-11'), (1, 'Gestão Ambiental', '2023-12-11', '2023-12-11'),
(1, 'Simulação Gerencial', '2023-12-11', '2023-12-11'), (1, 'Modelos de Negócios', '2023-12-11', '2023-12-11'),
(1, 'Mercado de Capitais', '2023-12-11', '2023-12-11'), (1, 'Oficina de Produtos V Extensão', '2023-12-11', '2023-12-11'),
(1, 'Administração Pública', '2023-12-11', '2023-12-11'), (1, 'Pesquisa em Administração', '2023-12-11', '2023-12-11'),
(1, 'Tópicos Especiais em Administração I', '2023-12-11', '2023-12-11'), (1, 'Agricultura Familiar', '2023-12-11', '2023-12-11'),
(1, 'Metodologia Científica II', '2023-12-11', '2023-12-11'), (1, 'Tópicos Especiais em Administração II', '2023-12-11', '2023-12-11'),
(1, 'Negócios Internacionais', '2023-12-11', '2023-12-11'), (1, 'Seminários de Administração', '2023-12-11', '2023-12-11'),
(1, 'Endomarketing', '2023-12-11', '2023-12-11'), (1, 'Clima e Cultura Organizacional', '2023-12-11', '2023-12-11'),
(1, 'Sociologia das Organizações', '2023-12-11', '2023-12-11'), (1, 'Desenvolvimento Local e Regional', '2023-12-11', '2023-12-11'),
(1, 'Estratégia e Planejamento de Negócios', '2023-12-11', '2023-12-11'), (1, 'Administração de Riscos', '2023-12-11', '2023-12-11'),
(1, 'Administração de Serviços', '2023-12-11', '2023-12-11'), (1, 'Consultoria e Auditoria Empresarial', '2023-12-11', '2023-12-11'),
(1, 'Empresas Verdes', '2023-12-11', '2023-12-11'), (1, 'Empreendedorismo para MEI', '2023-12-11', '2023-12-11'),
(1, 'Métodos Qualitativos de Pesquisa', '2023-12-11', '2023-12-11'), (1, 'Teoria dos Jogos', '2023-12-11', '2023-12-11'),
(1, 'Introdução a Ciência dos Dados', '2023-12-11', '2023-12-11'), (1, 'Controladoria', '2023-12-11', '2023-12-11'),
(1, 'Adminstração de Redes Sociais', '2023-12-11', '2023-12-11'), (1, 'Gestão da Diversidade nas Organizações', '2023-12-11', '2023-12-11'),
(1, 'Introdução a Computação', '2023-12-11', '2023-12-11'), (1, 'Introdução a Programação', '2023-12-11', '2023-12-11'),
(1, 'Metodologias Ativas no Ensino', '2023-12-11', '2023-12-11'), (1, 'Inglês Instrumental', '2023-12-11', '2023-12-11'),
(1, 'Tecnologia e Sociedade', '2023-12-11', '2023-12-11'), (1, 'Didática Geral', '2023-12-11', '2023-12-11'),
(1, 'Educação Inclusiva', '2023-12-11', '2023-12-11'), (1, 'Lógica Matemática', '2023-12-11', '2023-12-11'),
(1, 'Libras', '2023-12-11', '2023-12-11');

-- -----------------------------------------------------
-- Agronomia
-- -----------------------------------------------------

INSERT discipline(idCourse, name, createdAt, updatedAt) VALUES(2, 'Introdução à Extensão na Agronomia', '2023-12-11', '2023-12-11'),
(2, 'Biologia Celular', '2023-12-11', '2023-12-11'), (2, 'Fundamentos de Ciência do Solo', '2023-12-11', '2023-12-11'),
(2, 'Cálculo I - Fundamentos de Matemática', '2023-12-11', '2023-12-11'), (2, 'Introdução à Agronomia', '2023-12-11', '2023-12-11'),
(2, 'Química Geral', '2023-12-11', '2023-12-11'), (2, 'Zoologia Geral', '2023-12-11', '2023-12-11'),
(2, 'Álgebra Linear', '2023-12-11', '2023-12-11'), (2, 'Cálculo II - Diferencial e Integral', '2023-12-11', '2023-12-11'),
(2, 'Desenho Teórico', '2023-12-11', '2023-12-11'), (2, 'Histologia e Anatomia Vegetal', '2023-12-11', '2023-12-11'),
(2, 'Morfologia e Classificação do Solo', '2023-12-11', '2023-12-11'), (2, 'Química Orgânica', '2023-12-11', '2023-12-11'),
(2, 'Bioquímica', '2023-12-11', '2023-12-11'), (2, 'Estatística Básica', '2023-12-11', '2023-12-11'),
(2, 'Ecologia Básica', '2023-12-11', '2023-12-11'), (2, 'Física I', '2023-12-11', '2023-12-11'),
(2, 'Genética', '2023-12-11', '2023-12-11'), (2, 'Microbiologia Geral', '2023-12-11', '2023-12-11'),
(2, 'Morfologia e Sistemática Vegetal', '2023-12-11', '2023-12-11'), (2, 'Química Analítica', '2023-12-11', '2023-12-11'),
(2, 'Entomologia Geral', '2023-12-11', '2023-12-11'), (2, 'Fisiologia Vegetal', '2023-12-11', '2023-12-11'),
(2, 'Física do Solo', '2023-12-11', '2023-12-11'), (2, 'Física II', '2023-12-11', '2023-12-11'),
(2, 'Metodologia Científica', '2023-12-11', '2023-12-11'), (2, 'Microbiologia do Solo', '2023-12-11', '2023-12-11'),
(2, 'Zootecnia Geral', '2023-12-11', '2023-12-11'), (2, 'Estatística Experimental', '2023-12-11', '2023-12-11'),
(2, 'Fertilidade do Solo', '2023-12-11', '2023-12-11'), (2, 'Fitopatologia I', '2023-12-11', '2023-12-11'),
(2, 'Hidrologia', '2023-12-11', '2023-12-11'), (2, 'Mecanização Agrícola', '2023-12-11', '2023-12-11'),
(2, 'Propagação de Plantas', '2023-12-11', '2023-12-11'), (2, 'Tecnologia de Sementes', '2023-12-11', '2023-12-11'),
(2, 'Agrometeorologia', '2023-12-11', '2023-12-11'), (2, 'Biologia e Controle de Plantas Daninhas', '2023-12-11', '2023-12-11'),
(2, 'Entomologia e Acarologia Agrícola', '2023-12-11', '2023-12-11'), (2, 'Fitopatologia II', '2023-12-11', '2023-12-11'),
(2, 'Hidráulica', '2023-12-11', '2023-12-11'), (2, 'Topografia', '2023-12-11', '2023-12-11'),
(2, 'Fruticultura Geral', '2023-12-11', '2023-12-11'), (2, 'Irrigação e Drenagem', '2023-12-11', '2023-12-11'),
(2, 'Melhoramento de Plantas', '2023-12-11', '2023-12-11'), (2, 'Olericultura Geral', '2023-12-11', '2023-12-11'),
(2, 'Receituário e Tecnologia de Aplicação de Defensivos Agrícolas', '2023-12-11', '2023-12-11'), (2, 'Sistemas e Práticas Siviculturais', '2023-12-11', '2023-12-11'),
(2, 'Agroecologia', '2023-12-11', '2023-12-11'), (2, 'Contruções e Instalações Rurais', '2023-12-11', '2023-12-11'),
(2, 'Culturas da Soja e do Milho', '2023-12-11', '2023-12-11'), (2, 'Projeto de Conclusão de Curso', '2023-12-11', '2023-12-11'),
(2, 'Secagem e Armazenamento de Grãos', '2023-12-11', '2023-12-11'), (2, 'Sociologia e Extensão Rural', '2023-12-11', '2023-12-11'),
(2, 'Administração e Economia Rural', '2023-12-11', '2023-12-11'), (2, 'Práticas Complementares de Extensão', '2023-12-11', '2023-12-11'),
(2, 'Cafeicultura', '2023-12-11', '2023-12-11'), (2, 'Forragicultura e Pastagens', '2023-12-11', '2023-12-11'),
(2, 'Tecnologia de Produtos Agropecuários', '2023-12-11', '2023-12-11');

-- -----------------------------------------------------
-- Engenharia Florestal
-- -----------------------------------------------------

INSERT discipline(idCourse, name, createdAt, updatedAt) VALUES(3, 'Cálculo I - Fundamentos de Matemática', '2023-12-11', '2023-12-11'),
(3, 'Introdução à Engenharia Florestal', '2023-12-11', '2023-12-11'), (3, 'Sociologia', '2023-12-11', '2023-12-11'),
(3, 'Química Orgânica', '2023-12-11', '2023-12-11'), (3, 'Química Geral', '2023-12-11', '2023-12-11'),
(3, 'Desenho Técnico', '2023-12-11', '2023-12-11'), (3, 'Biologia Celular', '2023-12-11', '2023-12-11'),
(3, 'Álgebra Linear', '2023-12-11', '2023-12-11'), (3, 'Extensão aplicada à educação ambiental', '2023-12-11', '2023-12-11'),
(3, 'Zoologia geral', '2023-12-11', '2023-12-11'), (3, 'Fundamentos de Ciência do Solo', '2023-12-11', '2023-12-11'),
(3, 'Química Analítica', '2023-12-11', '2023-12-11'), (3, 'Estatística Básica', '2023-12-11', '2023-12-11'),
(3, 'Física I', '2023-12-11', '2023-12-11'), (3, 'Cálculo II - Diferencial e Integral', '2023-12-11', '2023-12-11'),
(3, 'Morfologia e Classificação do Solo', '2023-12-11', '2023-12-11'), (3, 'Histologia e Anatomia vegetal', '2023-12-11', '2023-12-11'),
(3, 'Topografia', '2023-12-11', '2023-12-11'), (3, 'Estatística Experimental', '2023-12-11', '2023-12-11'),
(3, 'Bioquímica', '2023-12-11', '2023-12-11'), (3, 'Morfologia e Sistemática Vegetal', '2023-12-11', '2023-12-11'),
(3, 'Ecologia Básica', '2023-12-11', '2023-12-11'), (3, 'Tecnologia de Sementes', '2023-12-11', '2023-12-11'),
(3, 'Microbiologia Geral', '2023-12-11', '2023-12-11'), (3, 'Fisiologia Vegetal ', '2023-12-11', '2023-12-11'),
(3, 'Fotogrametria e Fotointerpretação', '2023-12-11', '2023-12-11'), (3, 'Dendrologia', '2023-12-11', '2023-12-11'),
(3, 'Metodologia Científica', '2023-12-11', '2023-12-11'), (3, 'Física do Solo', '2023-12-11', '2023-12-11'),
(3, 'Entomologia Geral', '2023-12-11', '2023-12-11'), (3, 'Agrometeorologia', '2023-12-11', '2023-12-11'),
(3, 'Dendrometria', '2023-12-11', '2023-12-11'), (3, 'Propagação Florestal e Viveiros', '2023-12-11', '2023-12-11'),
(3, 'Mecanização Agrícola', '2023-12-11', '2023-12-11'), (3, 'Componentes Anatômicos e Químicos da Madeira', '2023-12-11', '2023-12-11'),
(3, 'Genética', '2023-12-11', '2023-12-11'), (3, 'Fertilidade do Solo', '2023-12-11', '2023-12-11'),
(3, 'Ecologia Florestal', '2023-12-11', '2023-12-11'), (3, 'Melhoramento e Biotecnologia Florestal', '2023-12-11', '2023-12-11'),
(3, 'Inventário Florestal', '2023-12-11', '2023-12-11'), (3, 'Física e Mecânica da Madeira', '2023-12-11', '2023-12-11'),
(3, 'Patologia Florestal', '2023-12-11', '2023-12-11'), (3, 'Geoprocessamento e Sensoriamento remoto', '2023-12-11', '2023-12-11'),
(3, 'Projeto de Conclusão de Curso', '2023-12-11', '2023-12-11'), (3, 'Sistemas e Práticas Silviculturais', '2023-12-11', '2023-12-11'),
(3, 'Entomologia Florestal', '2023-12-11', '2023-12-11'), (3, 'Comunicação e Extensão Florestal', '2023-12-11', '2023-12-11'),
(3, 'Energia da Biomassa Florestal', '2023-12-11', '2023-12-11'), (3, 'Manejo Florestal', '2023-12-11', '2023-12-11'),
(3, 'Administração Florestal', '2023-12-11', '2023-12-11'), (3, 'Restauração florestal', '2023-12-11', '2023-12-11'),
(3, 'Culturas florestais', '2023-12-11', '2023-12-11'), (3, 'Economia Florestal', '2023-12-11', '2023-12-11'),
(3, 'Colheita Florestal', '2023-12-11', '2023-12-11'), (3, 'Política e Legislação Florestal ', '2023-12-11', '2023-12-11'),
(3, 'Manejo e Gestão de Unidades de Conservação', '2023-12-11', '2023-12-11');

-- -----------------------------------------------------
-- Ciências Biologicas
-- -----------------------------------------------------

INSERT discipline(idCourse, name, createdAt, updatedAt) VALUES(5, 'Antropologia e Educação', '2023-12-11', '2023-12-11'),
(5, 'Biologia Celular', '2023-12-11', '2023-12-11'), (5, 'Física Aplicada a Ciências Biológicas', '2023-12-11', '2023-12-11'),
(5, 'Formação de Professores de Biologia', '2023-12-11', '2023-12-11'), (5, 'Introdução a Ciências Biológicas', '2023-12-11', '2023-12-11'),
(5, 'Matemática Aplicada a Ciências Biológicas', '2023-12-11', '2023-12-11'), (5, 'Microbiologia Geral', '2023-12-11', '2023-12-11'),
(5, 'Português Instrumental', '2023-12-11', '2023-12-11'), (5, 'Estatística Básica', '2023-12-11', '2023-12-11'),
(5, 'Genética', '2023-12-11', '2023-12-11'), (5, 'Histologia Animal', '2023-12-11', '2023-12-11'),
(5, 'História das Ciências Naturais ', '2023-12-11', '2023-12-11'), (5, 'Laboratório de Ensino de Biologia I', '2023-12-11', '2023-12-11'),
(5, 'Políticas Públicas na Educação Básica', '2023-12-11', '2023-12-11'), (5, 'Química Aplicada a Ciências Biológicas', '2023-12-11', '2023-12-11'),
(5, 'Biofísica', '2023-12-11', '2023-12-11'), (5, 'Biologia de Algas, Briófitas e Pteridófitas', '2023-12-11', '2023-12-11'),
(5, 'Bioquímica I', '2023-12-11', '2023-12-11'), (5, 'Geologia', '2023-12-11', '2023-12-11'),
(5, 'Metodologia Científica', '2023-12-11', '2023-12-11'), (5, 'Prática de Ensino de Ciências I', '2023-12-11', '2023-12-11'),
(5, 'Psicologia da Educação', '2023-12-11', '2023-12-11'), (5, 'Anatomia Humana', '2023-12-11', '2023-12-11'),
(5, 'Bioquímica II', '2023-12-11', '2023-12-11'), (5, 'Didática Geral', '2023-12-11', '2023-12-11'),
(5, 'Ecologia de Indivíduos e Populações', '2023-12-11', '2023-12-11'), (5, 'Evolução', '2023-12-11', '2023-12-11'),
(5, 'Histologia e Anatomia Vegetal', '2023-12-11', '2023-12-11'), (5, 'Biologia das Espermatófitas', '2023-12-11', '2023-12-11'),
(5, 'Fisiologia Humana', '2023-12-11', '2023-12-11'), (5, 'Imunologia', '2023-12-11', '2023-12-11'),
(5, 'Libras', '2023-12-11', '2023-12-11'), (5, 'Prática de Ensino de Ciências II', '2023-12-11', '2023-12-11'),
(5, 'Zoologia dos Invertebrados I ', '2023-12-11', '2023-12-11'), (5, 'Biologia Molecular', '2023-12-11', '2023-12-11'),
(5, 'Ecologia de Comunidades e Ecossistemas', '2023-12-11', '2023-12-11'), (5, 'Fisiologia Vegetal', '2023-12-11', '2023-12-11'),
(5, 'Prática de Ensino de Biologia', '2023-12-11', '2023-12-11'), (5, 'Projeto de Trabalho de Conclusão de Curso', '2023-12-11', '2023-12-11'),
(5, 'Zoologia dos Invertebrados II', '2023-12-11', '2023-12-11'), (5, 'Biologia do Desenvolvimento', '2023-12-11', '2023-12-11'),
(5, 'Educação Inclusiva', '2023-12-11', '2023-12-11'), (5, 'Filosofia da Educação', '2023-12-11', '2023-12-11'),
(5, 'Laboratório de Ensino de Biologia II', '2023-12-11', '2023-12-11'), (5, 'Zoologia dos Vertebrados I', '2023-12-11', '2023-12-11'),
(5, 'Gestão Educacional', '2023-12-11', '2023-12-11'), (5, 'Laboratório de Ensino de Biologia III', '2023-12-11', '2023-12-11'),
(5, 'Parasitologia', '2023-12-11', '2023-12-11'), (5, 'Sociologia da Educação', '2023-12-11', '2023-12-11'),
(5, 'Zoologia dos Vertebrados II', '2023-12-11', '2023-12-11');

-- -----------------------------------------------------
-- Matemática
-- -----------------------------------------------------

INSERT discipline(idCourse, name, createdAt, updatedAt) VALUES(6, 'Álgebra na Educação Básica I ', '2023-12-11', '2023-12-11'),
(6, 'Geometria na Educação Básica I', '2023-12-11', '2023-12-11'), (6, 'Psicologia da Educação', '2023-12-11', '2023-12-11'),
(6, 'Antropologia e Educação', '2023-12-11', '2023-12-11'), (6, 'Filosofia da Educação', '2023-12-11', '2023-12-11'),
(6, 'Filosofia da Educação', '2023-12-11', '2023-12-11'), (6, 'Formação de Professores de Matemática', '2023-12-11', '2023-12-11'),
(6, 'Álgebra na Educação Básica II', '2023-12-11', '2023-12-11'), (6, 'Geometria na Educação Básica II', '2023-12-11', '2023-12-11'),
(6, 'Didática Geral', '2023-12-11', '2023-12-11'), (6, 'Educação Inclusiva', '2023-12-11', '2023-12-11'),
(6, 'Metodologia Científica', '2023-12-11', '2023-12-11'), (6, 'Ensino de Números e Álgebra e Extensão', '2023-12-11', '2023-12-11'),
(6, 'Cálculo I', '2023-12-11', '2023-12-11'), (6, 'Desenho Geométrico', '2023-12-11', '2023-12-11'),
(6, 'Análise Combinatória', '2023-12-11', '2023-12-11'), (6, 'Lógica Matemática', '2023-12-11', '2023-12-11'),
(6, 'Português Instrumental', '2023-12-11', '2023-12-11'), (6, 'Recursos Computacionais', '2023-12-11', '2023-12-11'),
(6, 'Ensino de Geometria e Medidas e Extensão', '2023-12-11', '2023-12-11'), (6, 'Cálculo II', '2023-12-11', '2023-12-11'),
(6, 'Geometria Analítica', '2023-12-11', '2023-12-11'), (6, 'Matemática Financeira', '2023-12-11', '2023-12-11'),
(6, 'Estatística Básica', '2023-12-11', '2023-12-11'), (6, 'Sociologia da Educação', '2023-12-11', '2023-12-11'),
(6, 'Ensino de Estatística e Probabilidade e Extensão', '2023-12-11', '2023-12-11'), (6, 'Cálculo III', '2023-12-11', '2023-12-11'),
(6, 'Álgebra Linear', '2023-12-11', '2023-12-11'), (6, 'Física I', '2023-12-11', '2023-12-11'),
(6, 'Projeto de Trabalho de Conclusão de Curso', '2023-12-11', '2023-12-11'), (6, 'Laboratório de Ensino de Matemática I e Extensão', '2023-12-11', '2023-12-11'),
(6, 'Cálculo IV', '2023-12-11', '2023-12-11'), (6, 'Fundamentos de Análise', '2023-12-11', '2023-12-11'),
(6, 'Teoria dos Números', '2023-12-11', '2023-12-11'), (6, 'Física II', '2023-12-11', '2023-12-11'),
(6, 'Laboratório de Ensino de Matemática II e Extensão', '2023-12-11', '2023-12-11'), (6, 'Cálculo Numérico', '2023-12-11', '2023-12-11'),
(6, 'Seminários de Pesquisa em Matemática', '2023-12-11', '2023-12-11'), (6, 'Investigação em Educação Matemática', '2023-12-11', '2023-12-11'),
(6, 'Resolução de Problemas', '2023-12-11', '2023-12-11'), (6, 'Políticas Públicas na Educação Básica', '2023-12-11', '2023-12-11'),
(6, 'Intervenção Pedagógica em Matemática e Extensão', '2023-12-11', '2023-12-11'), (6, 'História da Matemática', '2023-12-11', '2023-12-11'),
(6, 'Modelagem Matemática na Educação Básica', '2023-12-11', '2023-12-11'), (6, 'Tendências em Educação Matemática', '2023-12-11', '2023-12-11'),
(6, 'Libras', '2023-12-11', '2023-12-11'), (6, 'Gestão Educacional', '2023-12-11', '2023-12-11'),
(6, 'Equações Diferenciais Ordinárias', '2023-12-11', '2023-12-11'), (6, 'Funções de Variáveis Complexas', '2023-12-11', '2023-12-11'),
(6, 'Estruturas Algébricas', '2023-12-11', '2023-12-11'), (6, 'Modelagem Matemática', '2023-12-11', '2023-12-11'),
(6, 'Matemática Discreta', '2023-12-11', '2023-12-11'), (6, 'Pesquisa Operacional', '2023-12-11', '2023-12-11'),
(6, 'Métodos Avançados de Contagem', '2023-12-11', '2023-12-11'), (6, 'Ludicidade no Ensino de Matemática', '2023-12-11', '2023-12-11'),
(6, 'História da Educação e Teorias de Currículo', '2023-12-11', '2023-12-11'), (6, 'Redação Técnico-Científica em Educação Matemática', '2023-12-11', '2023-12-11'),
(6, 'Metodologias Ativas de Ensino', '2023-12-11', '2023-12-11');

-- -----------------------------------------------------
-- Técnico em Agropecuária
-- -----------------------------------------------------

INSERT discipline(idCourse, name, createdAt, updatedAt) VALUES(9, 'Fundamentos e Prática de Agricultura', '2023-12-11', '2023-12-11'),
(9, 'Fundamentos e Prática de Zootecnia', '2023-12-11', '2023-12-11'), (9, 'Desenho Técnico em Computador', '2023-12-11', '2023-12-11'),
(9, 'Topografia', '2023-12-11', '2023-12-11'), (9, 'Máquinas e Motores', '2023-12-11', '2023-12-11'),
(9, 'Língua Portuguesa', '2023-12-11', '2023-12-11'), (9, 'Educação Física', '2023-12-11', '2023-12-11'),
(9, 'Informática', '2023-12-11', '2023-12-11'), (9, '', '2023-12-11', '2023-12-11'),
(9, 'Biologia', '2023-12-11', '2023-12-11'), (9, 'Química', '2023-12-11', '2023-12-11'),
(9, 'Física', '2023-12-11', '2023-12-11'), (9, 'Matemática', '2023-12-11', '2023-12-11'),
(9, 'História', '2023-12-11', '2023-12-11'), (9, 'Geografia', '2023-12-11', '2023-12-11'),
(9, 'Filosofia', '2023-12-11', '2023-12-11'), (9, 'Língua Estrangeira/Inglês ', '2023-12-11', '2023-12-11'),
(9, 'Culturas Anuais', '2023-12-11', '2023-12-11'), (9, 'Olericultura', '2023-12-11', '2023-12-11'),
(9, 'Suinocultura', '2023-12-11', '2023-12-11'), (9, 'Animais de Pequeno Porte', '2023-12-11', '2023-12-11'),
(9, 'Irrigação e Drenagem', '2023-12-11', '2023-12-11'), (9, 'Implementos Agrícolas', '2023-12-11', '2023-12-11'),
(9, 'Atividade Prática Orientada I', '2023-12-11', '2023-12-11'), (9, 'Culturas Perenes', '2023-12-11', '2023-12-11'),
(9, 'Caprinovinocultura', '2023-12-11', '2023-12-11'), (9, 'Bovinocultura e Equideocultura', '2023-12-11', '2023-12-11'),
(9, 'Processamento de Produtos de Origem Vegetal e Animal ', '2023-12-11', '2023-12-11'), (9, 'Forragicultura e Pastagem', '2023-12-11', '2023-12-11'),
(9, 'Gestão e Empreendedorismo', '2023-12-11', '2023-12-11'), (9, 'Atividade Prática Orientada II', '2023-12-11', '2023-12-11'),
(9, 'Língua Estrangeira/Espanhol', '2023-12-11', '2023-12-11');

-- -----------------------------------------------------
-- Técnico em Informática
-- -----------------------------------------------------

INSERT discipline(idCourse, name, createdAt, updatedAt) VALUES(7, 'Introdução à Computação', '2023-12-11', '2023-12-11'),
(7, 'Introdução à Computação', '2023-12-11', '2023-12-11'), (7, 'Introdução à Programação', '2023-12-11', '2023-12-11'),
(7, 'Sistemas operacionais', '2023-12-11', '2023-12-11'), (7, 'Redes de Computadores I', '2023-12-11', '2023-12-11'),
(7, 'Lógica Matemática', '2023-12-11', '2023-12-11'), (7, 'Software Aplicativos', '2023-12-11', '2023-12-11'),
(7, 'Língua Portuguesa', '2023-12-11', '2023-12-11'), (7, 'Educação Física', '2023-12-11', '2023-12-11'),
(7, 'Biologia', '2023-12-11', '2023-12-11'), (7, 'Química', '2023-12-11', '2023-12-11'),
(7, 'Física', '2023-12-11', '2023-12-11'), (7, 'Matemática', '2023-12-11', '2023-12-11'),
(7, 'História', '2023-12-11', '2023-12-11'), (7, 'Geografia', '2023-12-11', '2023-12-11'),
(7, 'Filosofia', '2023-12-11', '2023-12-11'), (7, 'Sociologia', '2023-12-11', '2023-12-11'),
(7, 'Língua Estrangeira/Inglês ', '2023-12-11', '2023-12-11'), (7, 'Banco de Dados I', '2023-12-11', '2023-12-11'),
(7, 'Linguagem de Programação I', '2023-12-11', '2023-12-11'), (7, 'Redes de Computadores I', '2023-12-11', '2023-12-11'),
(7, 'Instalação, Configuração e Manutenção de Computadores', '2023-12-11', '2023-12-11'), (7, 'Análise e Projeto de Sistemas', '2023-12-11', '2023-12-11'),
(7, 'Elaboração de Projetos', '2023-12-11', '2023-12-11'), (7, 'Linguagem de Programação II', '2023-12-11', '2023-12-11'),
(7, 'Banco de Dados II', '2023-12-11', '2023-12-11'), (7, 'Eletrônica', '2023-12-11', '2023-12-11'),
(7, 'Administração e Empreendedorismo', '2023-12-11', '2023-12-11'), (7, 'Projeto Integrador III', '2023-12-11', '2023-12-11'),
(7, 'Língua Estrangeira/Espanhol', '2023-12-11', '2023-12-11'), (7, 'Libras', '2023-12-11', '2023-12-11');

-- -----------------------------------------------------
-- Técnico em Nutrição e Dietética
-- -----------------------------------------------------

INSERT discipline(idCourse, name, createdAt, updatedAt) VALUES(8, 'Relações Humanas e Profissionais', '2023-12-11', '2023-12-11'),
(8, 'Fundamentos de Fisiologia e Anatomia Humana', '2023-12-11', '2023-12-11'), (8, 'Nutrição e Metabolismo', '2023-12-11', '2023-12-11'),
(8, 'Nutrição nas Fases da Vida', '2023-12-11', '2023-12-11'), (8, 'Controle Higiênico Sanitário', '2023-12-11', '2023-12-11'),
(8, 'Técnica Dietética', '2023-12-11', '2023-12-11'), (8, 'Língua Portuguesa', '2023-12-11', '2023-12-11'),
(8, 'Educação Física', '2023-12-11', '2023-12-11'), (8, 'Biologia', '2023-12-11', '2023-12-11'),
(8, 'Química', '2023-12-11', '2023-12-11'), (8, 'Física', '2023-12-11', '2023-12-11'),
(8, 'Matemática', '2023-12-11', '2023-12-11'), (8, 'História', '2023-12-11', '2023-12-11'),
(8, 'Geografia', '2023-12-11', '2023-12-11'), (8, 'Filosofia', '2023-12-11', '2023-12-11'),
(8, 'Sociologia', '2023-12-11', '2023-12-11'), (8, 'Língua Estrangeira/Inglês', '2023-12-11', '2023-12-11'),
(8, 'Informática', '2023-12-11', '2023-12-11'), (8, 'Tecnologia de Alimentos', '2023-12-11', '2023-12-11'),
(8, 'Gestão de UAN - Unidade de Alimentação e Nutrição', '2023-12-11', '2023-12-11'), (8, 'Avaliação e Educação Nutricional', '2023-12-11', '2023-12-11'),
(8, 'Dietoterapia I', '2023-12-11', '2023-12-11'), (8, 'Gestão e Empreendedorismo aplicados à Nutrição e Dietética', '2023-12-11', '2023-12-11'),
(8, 'Organização e Planejamento Físico em UAN', '2023-12-11', '2023-12-11'), (8, 'Elaboração e execução de Projetos Aplicados à Nutrição e Dietética', '2023-12-11', '2023-12-11'),
(8, 'Planejamento e Organização de Eventos', '2023-12-11', '2023-12-11'), (8, 'Dietoterapia II', '2023-12-11', '2023-12-11'),
(8, 'Nutrição e Saúde Coletiva', '2023-12-11', '2023-12-11'), (8, 'Ética e Orientação Profissiona', '2023-12-11', '2023-12-11'),
(8, 'Arte', '2023-12-11', '2023-12-11');

-- -----------------------------------------------------
-- Técnico em Agrimensura
-- -----------------------------------------------------

INSERT discipline(idCourse, name, createdAt, updatedAt) VALUES(10, 'Topografia I', '2023-12-10', '2023-12-10'),
(10, 'Desenho Técnico Topográfico', '2023-12-10', '2023-12-10'), (10, '', '2023-12-10', '2023-12-10'),
(10, 'Matemática Aplicada I', '2023-12-10', '2023-12-10'), (10, 'Informática Básica', '2023-12-10', '2023-12-10'),
(10, 'Inglês Técnico', '2023-12-10', '2023-12-10'), (10, 'Relações Interpessoais', '2023-12-10', '2023-12-10'),
(10, 'Iniciação à Metodologia Científica', '2023-12-10', '2023-12-10'), (10, 'Legislação Aplicada à Agrimensura', '2023-12-10', '2023-12-10'),
(10, 'Topografia II', '2023-12-10', '2023-12-10'), (10, 'Matemática Aplicada II', '2023-12-10', '2023-12-10'),
(10, 'Cartografia', '2023-12-10', '2023-12-10'), (10, 'Fundamentos de Geodésia', '2023-12-10', '2023-12-10'),
(10, 'Hidrologia', '2023-12-10', '2023-12-10'), (10, 'Solos', '2023-12-10', '2023-12-10'),
(10, 'Informática Aplicada à Agrimensura', '2023-12-10', '2023-12-10'), (10, 'Topografia III', '2023-12-10', '2023-12-10'),
(10, 'Fotogrametria e Sensoriamento Remoto', '2023-12-10', '2023-12-10'), (10, 'Planejamento Urbano', '2023-12-10', '2023-12-10'),
(10, 'Métodos de Posicionamento por Satélites', '2023-12-10', '2023-12-10'), (10, 'Projeto Geométrico de Estradas', '2023-12-10', '2023-12-10'),
(10, 'Gestão e Empreendedorismo', '2023-12-10', '2023-12-10'), (10, 'Sistemas de Informações Geográficas', '2023-12-10', '2023-12-10'),
(10, 'Libras', '2023-12-10', '2023-12-10');

-- -----------------------------------------------------
-- Especialização em Meio Ambiente
-- -----------------------------------------------------

INSERT discipline(idCourse, name, createdAt, updatedAt) VALUES(11, 'Metodologia de Pesquisa Científica', '2023-12-10', '2023-12-10'),
(11, 'Ambientação em Educação à Distância', '2023-12-10', '2023-12-10'), (11, 'Ecologia e Meio Ambiente', '2023-12-10', '2023-12-10'),
(11, 'Educação Ambiental', '2023-12-10', '2023-12-10'), (11, 'Poluição e Saneamento Ambiental', '2023-12-10', '2023-12-10'),
(11, 'Avaliação de Impactos e Licenciamento Ambiental', '2023-12-10', '2023-12-10'), (11, 'Gestão Ambiental e Políticas Públicas', '2023-12-10', '2023-12-10'),
(11, 'Restauração e Recuperação Ambiental', '2023-12-10', '2023-12-10'), (11, 'Análise e Interpretação de Dados Ambientais', '2023-12-10', '2023-12-10');

-- -----------------------------------------------------
-- Especialização em Ensino e Tecnologias Educacionais
-- -----------------------------------------------------

INSERT discipline(idCourse, name, createdAt, updatedAt) VALUES(12, 'Metodologia de Pesquisa Científica', '2023-12-10', '2023-12-10'),
(12, 'Ambientação em Educação à Distância', '2023-12-10', '2023-12-10'), (12, 'Educação Inclusiva e Políticas Públicas Educacionais', '2023-12-10', '2023-12-10'),
(12, 'Ciência, Tecnologia, Sociedade e Ambiente', '2023-12-10', '2023-12-10'), (12, 'Poluição e Saneamento Ambiental', '2023-12-10', '2023-12-10'),
(12, 'Avaliação de Impactos e Licenciamento Ambiental', '2023-12-10', '2023-12-10'), (12, 'Formação de Professores na Contemporaneidade', '2023-12-10', '2023-12-10'),
(12, 'Seminários de Pesquisa', '2023-12-10', '2023-12-10'), (12, 'História e Filosofia da Ciência', '2023-12-10', '2023-12-10'),
(12, 'Tecnologias Educacionais Digitais', '2023-12-10', '2023-12-10'), (12, 'Educação Profissional e Tecnológica', '2023-12-10', '2023-12-10'),
(12, 'Ensino de Física', '2023-12-10', '2023-12-10'), (12, 'Ensino de Matemática', '2023-12-10', '2023-12-10'),
(12, 'Ensino de Química', '2023-12-10', '2023-12-10'), (12, 'Ensino de Biologia', '2023-12-10', '2023-12-10'),
(12, 'Educação em Humanidades', '2023-12-10', '2023-12-10'), (12, 'Alfabetização Científica', '2023-12-10', '2023-12-10'),
(12, 'Prática de Pesquisa Orientada', '2023-12-10', '2023-12-10');

-- -----------------------------------------------------
-- Especialização em Gestão
-- -----------------------------------------------------

INSERT discipline(idCourse, name, createdAt, updatedAt) VALUES(13, 'Metodologia da Pesquisa', '2023-12-10', '2023-12-10'),
(13, 'Gestão de Custos e Formação de Preços', '2023-12-10', '2023-12-10'), (13, 'Economia Empresarial', '2023-12-10', '2023-12-10'),
(13, 'Gestão Mercadológica', '2023-12-10', '2023-12-10'), (13, 'Gestão Estratégica', '2023-12-10', '2023-12-10'),
(13, 'Gestão de Equipes e Pessoas', '2023-12-10', '2023-12-10'), (13, 'Gestão de Operações e Logística', '2023-12-10', '2023-12-10'),
(13, 'Empreendedorismo e Inovação', '2023-12-10', '2023-12-10'), (13, 'Estratégias de Negociação e Gerenciamento de Conflitos', '2023-12-10', '2023-12-10'),
(13, 'Modelos e Ferramentas de Gestão', '2023-12-10', '2023-12-10'), (13, 'Empreendedorismo Digital', '2023-12-10', '2023-12-10'),
(13, 'Gestão Financeira e Análise de Investimentos', '2023-12-10', '2023-12-10'), (13, 'Comportamento do Consumidor e Pesquisa de Mercado', '2023-12-10', '2023-12-10'),
(13, 'Marketing Estratégico', '2023-12-10', '2023-12-10'), (13, '', '2023-12-10', '2023-12-10'),
(13, 'Comunicação Integrada e Marketing Digital', '2023-12-10', '2023-12-10'), (13, 'Competitividade Estratégica', '2023-12-10', '2023-12-10'),
(13, 'Teoria da Inovação', '2023-12-10', '2023-12-10'), (13, 'Estratégias em Negócios Inovadores', '2023-12-10', '2023-12-10'),
(13, 'Propriedade Intelectual e Transferência de Tecnologia', '2023-12-10', '2023-12-10'), (13, 'Sustainability Marketing para Novos Negócios', '2023-12-10', '2023-12-10'),
(13, 'Trabalho de Conclusão de Curso', '2023-12-10', '2023-12-10');