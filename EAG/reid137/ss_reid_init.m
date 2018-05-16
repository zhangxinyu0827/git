 function net=ss_reid_init()
addpath('./')
%   addpath('/ivy-caffe-code-v27/matlab');
addpath('/home/hawkeye936/Downloads/zxy/ivy-caffe-v30/matlab');
%  addpath(genpath('/ivy-caffe-code-v27'));


% Set caffe mode
% if exist('use_gpu', 'var') && use_gpu

  caffe.set_mode_gpu();
  gpu_id = 0;  % we will use the first gpu in this demo
  caffe.set_device(gpu_id);
  
% else
%   caffe.set_mode_cpu();
% end

% Initialize the network using BVLC CaffeNet for image classification
% Weights (parameter) file needs to be downloaded from Model Zoo.
model_dir = 'reid137/';
net_model = [ model_dir  're_id_test.prototxt'];
net_weights = [ model_dir  'No137_iter_100000.caffemodel'];
phase = 'test'; % run with phase test (so that dropout isn't applied)

% Initialize a network
net = caffe.Net(net_model,net_weights, phase);

%im=imread('reid_test/100000001.jpg');
% prepare oversampled input
% input_data is Height x Width x Channel x Num
 end
