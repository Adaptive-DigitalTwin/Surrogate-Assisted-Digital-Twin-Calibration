
parameters= {'BARE','Zone1'};
x0 = [1.5, 2.5];
%x0 = [2.0, 3.33];
%tru_sol_x0 = [2.0, 3.33333, 7.0, 7.0, 0.66667];

calibration_data_type = {'voltage', 'normal current density'};

metric = 'nmsq';

%IPs_IDs1 = MPs_IDs(1:4:end);

IPs_IDs1 = [32866,32886,32870,32874,32882,32846,32850,32878,32854   32858,32890,32862];

IDs_current_density = [ 7400, 16000, 19860, 23802];

IDs = {py.list(IPs_IDs1), py.list(IDs_current_density)};
IDs_mat_arr = {IPs_IDs1, IDs_current_density};

IDs_types = {'Internal Points', 'Mesh Points'};
%%
%IDs = meas_data_Internal_Points(:,1);

DOE_range1 = [1.0, 2.5; 3.0, 3.8]; 

%DOE experiment for 2 varaibles using Central Composite Design
Central_composite_points = ccdesign(2, 'type', 'inscribed', 'center' , 1);

DOE_sample_points1 = reverse_normalization(Central_composite_points, DOE_range1);

parameters_np_array1 = convert_arr_to_python_2d_list(DOE_sample_points1);
%DOE_sample_points = [DOE_sample_points ;reverse_normalization(Central_composite_points, DOE_range2)];
%%
root_folder = 'D:\DOE_nd_data_generation\Multilinear_pol_curves\Parameter_BARE_Zone1';

simulation_seed_folder = fullfile(root_folder,'Initial_files');
%simulation_seed_folder  = "C:\Users\msapkota\EXPERIMENT\DOE_nd_data_generation\Model_updated_linear\Parameter_BARE_Zone1\Initial_files1";

collection_dir = fullfile(root_folder,'Simulation_results');

snapshots_py = py.BEASY_IN_OUT1.snapshots_for_given_parameters_and_IDs(py.list(parameters), parameters_np_array1, py.list(IDs), py.list(calibration_data_type), simulation_seed_folder, collection_dir, py.list(IDs_types));

snapshots = double(snapshots_py);
%%
surrogates = response_surface(DOE_sample_points1, snapshots, 2);
%}
%%
testing_par = [1.49, 3.21];

test_dict =  py.BEASY_IN_OUT1.get_response_data_for_IDs_and_input_parameters(parameters, testing_par, simulation_seed_folder, collection_dir, py.list(calibration_data_type), py.list(IDs), py.list(IDs_types));

test_simulation_data = convert_pydict2data(test_dict,1);

test_surrogate_output = output_from_surrogates(testing_par, surrogates,[length(IDs{1}), length(IDs{2})]); 

normalised_mean_sq_diff(test_simulation_data, test_surrogate_output, calibration_data_type, [2 1])

%%
figure;

ax = gca;

data_count = 1;
difference_in_bar_chart(ax,test_simulation_data{data_count}, test_surrogate_output{data_count},{'data from simulation','data predicted by surrogate'});

if isequal(data_count, 2)
    %difference_in_bar_chart(ax,solution_data{data_count}, calib_data_inc_error{data_count},{'simulation data from calibrated model','calibration data', 'difference'});

    ylabel('Normal Current Density (mA/m^2)');
    ylim([-4000 -2000]);
else
    ylim([-880 -800]);
    ylabel(ax, 'Potential difference Ag/Agcl/Sea-water (mV)');
end
xlabel(strcat(IDs_types{data_count}, ' IDs'));


%%
calib_dir = fullfile(root_folder,'Calibration_data');

calib_data_file_err_inc = 'data_with_error_MP_IDs_Ncd.xlsx';

%{
if ~isfile(fullfile(calib_dir, calib_data_file_err_inc))
    all_position_dict = py.BEASY_IN_OUT1.get_output_data_for_IDs_from_simulation_folder(calib_dir, 'BU_Jacket_newCurves', py.list(calibration_data_type),  py.list({py.list(IPs_IDs), py.list(IDs_current_density)}), py.list(IDs_types));
    all_position_data = convert_pydict2data(all_position_dict,0);
    introduce_error_and_write_file( {IPs_IDs, IDs_current_density.'},all_position_data, calib_dir, calib_data_file_err_inc,1);
end
%model_out = output_from_surrogates([2.0, 3.0], surrogates, [17,6]);
%}
calib_data_inc_error = data_from_tables2(fullfile(calib_dir, calib_data_file_err_inc), IDs_mat_arr, 3);
calib_data_no_error = py.BEASY_IN_OUT1.get_output_data_for_IDs_from_simulation_folder(calib_dir, 'BU_Jacket_newCurves', py.list(calibration_data_type),  py.list(IDs), py.list(IDs_types));
calib_data_no_error = convert_pydict2data(calib_data_no_error,0);
%%


figure;

ax = gca;

[plot_data,f_min, min_out_pos1] = plot_objective_with_surrogates(ax, DOE_range1, surrogates, calib_data_inc_error, 'nmsq', calibration_data_type, [length(IDs{1}), length(IDs{2})],[0.66, 0.33], [0.025,0.025]);

output_from_surrogate = output_from_surrogates(min_out_pos1, surrogates,[length(IDs{1}), length(IDs{2})]); 

xlabel('Material 1 related p-value');
ylabel('Sea-water conductivity');
%%


testing_par_value = [1.99, 3.34];


    solution_dict =  py.BEASY_IN_OUT1.get_response_data_for_IDs_and_input_parameters(parameters, testing_par_value, simulation_seed_folder, collection_dir, py.list(calibration_data_type), py.list(IDs), py.list(IDs_types));

    solution_data = convert_pydict2data(solution_dict,1);

    normalised_mean_sq_diff(solution_data, calib_data_inc_error, calibration_data_type, [2 1])


%%
figure;

ax = gca;

difference_in_bar_chart(ax,solution_data{1}, calib_data_inc_error{1},{'simulation data from calibrated model','calibration data'});
%difference_in_bar_chart(ax,solution_data{1}(1:3:end,:), output_from_surrogate{1}(1:3:end,:),{'simulation data from calibrated model','calibration data', 'difference'});
%difference_in_bar_chart(ax,solution_data{3}(1:25:end,:), output_from_surrogate{3}(1:25:end,:),{'simulation output data','surrogate output data', 'difference'});

if isequal(data_count, 2)
    %difference_in_bar_chart(ax,solution_data{data_count}, calib_data_inc_error{data_count},{'simulation data from calibrated model','calibration data', 'difference'});

    ylabel('Normal Current Density (mA/m^2)');
    ylim([-4000 -2000]);
else
    ylim([-860 -780]);
    ylabel(ax, 'Potential difference Ag/Agcl/Sea-water (mV)');
end
xlabel(strcat(IDs_types{data_count}, ' IDs'));
%}
%%


function de_normaised_data = reverse_normalization(normalised_data, value_ranges)

de_normaised_data = zeros(size(normalised_data));

for i = 1:size(normalised_data, 2)
    
    de_normaised_data(:,i) = value_ranges(i,1)+ diff(value_ranges(i,:))/2 * (normalised_data(:,i)-(-1));
    
end
end
