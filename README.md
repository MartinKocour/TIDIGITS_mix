# TIDIGITS_mix
Speech corpus with mixed audio from TIDIGITS dataset.

## Data preparation
1. Please set `TIDIGITS` variable inside `prepare_data.sh`
2. Run `./prepare_data.sh`

## 2mix data description


|                | Train. |             |   Test   |           |
|---------------:|:------:|-------------|:--------:|-----------|
|        Genders | #pairs| hours        | #pairs  | hours      |
|        F + F | 22 171 | 13.8          | 2 177 | 1.3          |
|        M + M | 20 633 | 12.3          | 2 099 | 1.3          |
|           same | 41 266 | 26.1        | 4 276 | 2.6          |
|      different | 43 362 | 26.4        | 4 424 | 2.7          |
|      **Total** | 86 166 | **52.5**    | 8 700 | **5.3**      |
