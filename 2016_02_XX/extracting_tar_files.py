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
target_folder             = "/scratch-shared/edwin/iwmi_runs/"

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




# python extracting_tar_files.py 0	 50  &
# python extracting_tar_files.py 51	 100 &
# python extracting_tar_files.py 101 150 &
# python extracting_tar_files.py 151 200 &
# python extracting_tar_files.py 201 250 &
# python extracting_tar_files.py 251 300 &
# python extracting_tar_files.py 301 350 &
# python extracting_tar_files.py 351 400 &
# python extracting_tar_files.py 401 450 &
# python extracting_tar_files.py 451 500 &
# python extracting_tar_files.py 501 550 &
# python extracting_tar_files.py 551 600 &
# python extracting_tar_files.py 601 650 &
# python extracting_tar_files.py 651 674 &
# wait




