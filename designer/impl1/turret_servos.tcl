# Created by Microsemi Libero Software 11.9.0.4
# Mon Apr 15 19:32:49 2019

# (OPEN DESIGN)

open_design "turret_servos.adb"

# set default back-annotation base-name
set_defvar "BA_NAME" "turret_servos_ba"
set_defvar "IDE_DESIGNERVIEW_NAME" {Impl1}
set_defvar "IDE_DESIGNERVIEW_COUNT" "1"
set_defvar "IDE_DESIGNERVIEW_REV0" {Impl1}
set_defvar "IDE_DESIGNERVIEW_REVNUM0" "1"
set_defvar "IDE_DESIGNERVIEW_ROOTDIR" {C:\Users\celinesc\Desktop\ps2_turret_ir_integration\designer}
set_defvar "IDE_DESIGNERVIEW_LASTREV" "1"


# import of input files
import_source  \
-format "edif" -edif_flavor "GENERIC" -netlist_naming "VERILOG" {../../synthesis/turret_servos.edn} \
-format "pdc"  {..\..\component\work\turret_servos\turret_servos.pdc} -merge_physical "yes" -merge_timing "yes"
compile
report -type "status" {turret_servos_compile_report.txt}
report -type "pin" -listby "name" {turret_servos_report_pin_byname.txt}
report -type "pin" -listby "number" {turret_servos_report_pin_bynumber.txt}

save_design
