#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import shutil
import sys
import glob

start_number = int(sys.argv[1])
end_number   = int(sys.argv[2])

location_of_archive_files = "/scratch-shared/edwinwce/iwmi_runs/"
front_file_name           = "code__a__"
file_name_extension       = ".tar"

target folder             = "/scratch-shared/edwinhs/iwmi_runs/"

for i in range(start_number, end_number + 1, 1):
    # make the output folder
    pcrglobwb_output_folder = location_of_archive_files + front_file_name + str(i) + file_name_extension
    if os.path.exists(pcrglobwb_output_folder): shutil.rmtree(pcrglobwb_output_folder)
    os.makedirs(pcrglobwb_output_folder)
    # untar to the output folder
    cmd = "tar -xvf " + location_of_archive_files + front_file_name + str(i) + ".tar -C " + "code__a__" + str(i)
    print(cmd)
    os.system(cmd)
