# HifBaselineConverter


## Setup

To setup the converter run:

```bash
$ make docker-build
```

## Usage

To convert your baseline data - place the data inside the `baseline-data` directory and run:

```bash
$ make convert BASELINE=<path to spreadsheet> URL=<api url>/project/create
```
