# GitHub README.md

This is a MATLAB project that uses `BEASY_IN_OUT1` module to generate simulation data, and the generated code using MATLAB tools to generate a surrogate (response surface), evaluate the accuracy of the surrogate model, use the surrogate to find the solution parameter based upon the calibration data provided, and plot the results.

Most of the experiment related procedure are already described into the thesis chapter, but also in the MATLAB 'main.mlx' file, however few more details with categorisation of the requirements are provided below: 

## Usage

To run the code, first provide the necessary inputs to the following variables:

- `parameters`: A cell array of strings that contains the names of the parameters of interest.
- `calibration_data_type`: A cell array of strings that contains the types of calibration data (for example the array could contain one or few of from these: 'voltage', 'normal current density' or 'electric field')
- `metric`: A string that specifies the performance metric to use for optimization.
- `IDs`: A cell array of lists, where each list consist of IDs for the corresponding calibration data type. 
- `IDs_types`: A cell array of strings that contains the types of the data IDs (IDs types are given in the simulation files, such as 'Internal Points' , 'Mesh Points' , 'Element Points') .
- `DOE_range1`: A 2x2 matrix that specifies the range of the DOE experiment for two variables.
- `root_folder`: A string that specifies the root folder for storing simulation and calibration data.
- `simulation_seed_folder`: A string that specifies the folder that contains the initial simulation files, this should contains following 3 files incase of BEASY related experiments:
-     .mat_cp (it holds the material related polarsation behaviour)
-     .dat (It holds the strucutre geomertical data including the meshing and their co-ordinates)
-     .bat (This the the simulation running file, which once runs by taking the above two files generates the output by claling the BEASY software)
- `collection_dir`: A string that specifies the folder for storing simulation results.
- `testing_par`: A vector of parameter values for testing the surrogate model.
- `calib_dir`: A string that specifies the folder that contains the calibration data.
- `calib_data_file_err_inc`: A string that specifies the name of the file that contains the calibration data with error (The file should be in excel or csv file format).
- `calib_data_no_error`: A dictionary that contains the calibration data without error .
- `calib_data_inc_error`: A cell array of matrices that contains the calibration data with error.

After providing the necessary inputs, run the code in the `main.m` file. The code will generate simulation data, generate a surrogate (response surface), evaluate the accuracy of the surrogate model, use the surrogate to find the solution parameter based upon the calibration data provided, and plot the results.

## Dependencies

This project requires the following MATLAB (or external) modules:

- `BEASY_IN_OUT1 (python-based)`: User built python module to obtain and modify Input-Output dataset to the BEASY model.
- `ccdesign` 
- `fit`
- `PYTHON software with the packages numpy, os, pandas, shutil and re` (should be installed in the system)

## References

For more information on the modules used in this project, please refer to the following resources:

- `ccdesign`: [https://www.mathworks.com/help/stats/ccdesign.html](https://www.mathworks.com/help/stats/ccdesign.html)
- `fit` : [https://uk.mathworks.com/help/curvefit/fit.html](https://uk.mathworks.com/help/curvefit/fit.html)
