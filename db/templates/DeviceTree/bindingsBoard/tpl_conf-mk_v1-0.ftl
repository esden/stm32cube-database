[#ftl]
# SPDX-License-Identifier: BSD-2-Clause

flavor_dts_file-${mx_socDtRPN?substring(5,9)?upper_case} = ${mx_socRPN}-${mx_projectName}-mx.dts
flavorlist-${mx_socDtRPN?substring(5,9)?upper_case} += flavor_dts_file-${mx_socDtRPN?substring(5,9)?upper_case}