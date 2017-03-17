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
target_folder             = "/scratch-shared/edwinhs/iwmi_runs/"

for i in range(start_number, end_number + 1, 1):
    # make the output folder
    extracted_output_folder = target_folder + "code__a__" + str(i)
    if os.path.exists(extracted_output_folder): shutil.rmtree(extracted_output_folder)
    os.makedirs(extracted_output_folder)
    # archive source file
    source_tar_file = location_of_archive_files + front_file_name + str(i) + file_name_extension
    # untar to the output folder
    cmd = "tar -xvf " + source_tar_file + " -C " + extracted_output_folder
    print(cmd); os.system(cmd)



