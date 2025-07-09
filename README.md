# Gemini CLI Context Engineering Template

This project is a template for setting up a structured environment for context engineering with the Gemini CLI. It provides a clear workflow for generating and executing Product Requirements Prompts (PRPs).

## Overview

The core idea of this template is to separate the feature request, the context, and the execution of the prompts. This allows for a more organized and repeatable workflow when working with the Gemini CLI.

## Workflow

The workflow is divided into three main steps:

### Step 1: Define the Feature Request (`INITIAL.md`)

The first step is to define the feature you want to build. This is done by customizing the `INITIAL.md` file. This file contains a template for a feature request, including sections for the goal, inspiration, required knowledge, and potential pitfalls.

### Step 2: Generate the PRP (`generate-prp.sh`)

Once you have defined the feature request in `INITIAL.md`, you can generate a Product Requirements Prompt (PRP) using the `generate-prp.sh` script located in the `.gemini` directory.

To generate a PRP, run the following command from the project root:

```bash
.gemini/generate-prp.sh
```

This script will create a new PRP file in the `PRPs` directory. The new PRP file will be a combination of the `prp_base.md` template, the `GEMINI.md` context file, and the `INITIAL.md` feature request.

### Step 3: Execute the PRP (`run-prp.sh`)

After generating the PRP, you can "execute" it using the `run-prp.sh` script. This script takes the name of the PRP file as an argument.

To execute a PRP, run the following command from the project root:

```bash
.gemini/run-prp.sh <prp-file-name>
```

Currently, this script only prints the content of the PRP file. You can modify this script to pipe the content to the Gemini CLI or any other command.

## Project Structure

```
.
├── GEMINI.md
├── INITIAL.md
├── PRPs
│   └── PRP-20250709-150901.md
├── README.md
├── examples
├── src
└── .gemini
    ├── generate-prp.sh
    ├── prp_base.md
    └── run-prp.sh
```

*   `GEMINI.md`: Contains the core principles and conventions for the project.
*   `INITIAL.md`: A template for defining a feature request.
*   `PRPs`: A directory where the generated PRP files are stored.
*   `README.md`: This file.
*   `examples`: A directory for code examples.
*   `src`: A directory for the source code of your project.
*   `.gemini`: A hidden directory for the scripts and templates used in this workflow.
