# GitHub README.md

This is a MATLAB project that uses `BEASY_IN_OUT1` module to generate simulation data, calibrate a response surface, and evaluate the accuracy of the surrogate model by comparing it with simulation data. 

## Usage

To run the code, first provide the necessary inputs to the following variables:

- `parameters`: A cell array of strings that contains the names of the parameters to be varied.
- `calibration_data_type`: A cell array of strings that contains the types of calibration data.
- `metric`: A string that specifies the performance metric to use for optimization.
- `IDs`: A cell array of two lists, where the first list contains internal points IDs and the second list contains mesh points IDs.
- `IDs_types`: A cell array of strings that contains the types of the IDs.
- `DOE_range1`: A 2x2 matrix that specifies the range of the DOE experiment for two variables.
- `root_folder`: A string that specifies the root folder for storing simulation and calibration data.
- `simulation_seed_folder`: A string that specifies the folder that contains the initial simulation files.
- `collection_dir`: A string that specifies the folder for storing simulation results.
- `testing_par`: A vector of parameter values for testing the surrogate model.
- `calib_dir`: A string that specifies the folder that contains the calibration data.
- `calib_data_file_err_inc`: A string that specifies the name of the file that contains the calibration data with error.
- `calib_data_no_error`: A dictionary that contains the calibration data without error.
- `calib_data_inc_error`: A cell array of matrices that contains the calibration data with error.

After providing the necessary inputs, run the code in the `main.m` file. The code will generate simulation data, generate a surrogate (response surface), evaluate the accuracy of the surrogate model, use the surrogate to find the solution parameter based upon the calibration data provided, and plot the results.

## Dependencies

This project requires the following MATLAB modules:

- `BEASY_IN_OUT1`: User built python module to obtain and modify Input-Output dataset to the BEASY model.
- `ccdesign` 

## References

For more information on the modules used in this project, please refer to the following resources:

- `ccdesign`: [https://www.mathworks.com/help/stats/ccdesign.html](https://www.mathworks.com/help/stats/ccdesign.html)
