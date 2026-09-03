# PIM Model

```text
project/
├── dra_figs/
├── sdk/                             # the UPMEM SDK
├── static_analyzer/                 # data movement cost analyzer
│   ├── run_benchmarks.sh            # generate symoblic expression result
│   └── build_and_run_benchmarks.sh  # build the static analyzer and generate symbolic expression result
├── uPIMulator/                      # the uPIMulator project
├── run_simulator.sh                 # run the golang vesion uPIMulator
└── run_draw_figs.sh                 # regenerate figs from the results of static_analyzer / instruction_count_analyzer / uPIMulator 
```