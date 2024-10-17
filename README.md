# Metric Time Utils
*Utils for metric time conversion*

For more info see:
- https://en.wikipedia.org/wiki/Decimal_time
- https://metric-time.com/

## Polybar Integration
Add this module to your polybar config
```sh
[module/metric_time]
type = custom/script
exec = /path/to/script.sh
tail = true
click-left = kill -USR1 %pid%
```
