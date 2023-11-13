# GitHub README.md

This project follows the similar parameter calibration problem https://github.com/Adaptive-DigitalTwin/Simulator-based-Digital-Twin , but with different approach. This MATLAB project utilises simulation data and MATLAB tools to collect data, generate surrogate models (response surface) and evaluate the accuracy of the surrogate model(s). Then the surrogate(s) is(are) used to find the solution parameter based upon the calibration data provided. 

The experiment related procedures are described into the thesis chapter, but also in the MATLAB _'main.mlx'_ file, however few more details with categorisation of the requirements are provided below: 

#### Note: 
This experiment utilises the _Cathodic-Protection (CP) Model_ which is constructed using the _BEASY software  (V21)_. As a result, the data types primarily pertain to the CP model. However, this experiment can be replicated for similar problems, necessitating the simulation solver and support for data description and retrieval. Therefore, users must modify the codes for data retrieval and feeding or build their own for the specific model and simulator they are using. Additionally, the following requirements should be adjusted accordingly.


## Usage

To run the code, first provide the necessary inputs into the _'main.mlx'_ file associated with the following variables:

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

After providing the necessary inputs, run the code in the _`main.mlx`_ file step by step. The code will generate simulation data, generate a surrogate (response surface), evaluate the accuracy of the surrogate model, use the surrogate to find the solution parameter based upon the calibration data provided, and plot the results.

## Output 

The aim of the experiment is to obtain the solution parameters which will be obtained as _'min_out_pos1'_ after the experiment. But also the additional process data can be visualised and seen in the _'main.mlx'_ file itself while the simulation data will be stored into the collection directory. The performance of model with solution parameter is also analysed after obtaining the solution.


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
