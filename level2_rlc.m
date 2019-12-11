function varargout = level2_rlc(varargin)
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @level2_rlc_OpeningFcn, ...
                       'gui_OutputFcn',  @level2_rlc_OutputFcn, ...
                       'gui_LayoutFcn',  [] , ...
                       'gui_Callback',   []);
    if nargin && ischar(varargin{1})
        gui_State.gui_Callback = str2func(varargin{1});
    end

    if nargout
        [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
    else
        gui_mainfcn(gui_State, varargin{:});
    end
% DO NOT EDIT


function level2_rlc_OpeningFcn(hObject, eventdata, handles, varargin)
    handles.output = hObject;
    
    axes(handles.axes);
    hold on
    grid on
    
    handles.metricdata.l = 0;
    handles.metricdata.c = 0;
    handles.metricdata.r = 0;
    handles.metricdata.us = 0;
    handles.metricdata.uc0 = 0;
    handles.metricdata.il0 = 0;
    
    guidata(hObject, handles);

function varargout = level2_rlc_OutputFcn(hObject, eventdata, handles) 
    varargout{1} = handles.output;


function reset_pushbutton_Callback(hObject, eventdata, handles)
    cla(handles.axes);

    handles.metricdata.l = 0;
    handles.metricdata.c = 0;
    handles.metricdata.r = 0;
    handles.metricdata.us = 0;
    handles.metricdata.uc0 = 0;
    handles.metricdata.il0 = 0;
    
    set(handles.l_input, "String", handles.metricdata.l);
    set(handles.c_input, "String", handles.metricdata.c);
    set(handles.r_input, "String", handles.metricdata.r);
    set(handles.us_input, "String", handles.metricdata.us);
    set(handles.uc0_input, "String", handles.metricdata.uc0);
    set(handles.il0_input, "String", handles.metricdata.il0);
    
    guidata(hObject, handles);
    
    
% https://www.zybang.com/question/76ec3e7e695418a90dac559ebfb0b8ee.html
function dydt = func_rlc(t, y, r, l, c, us)
    % y(1) : uc
    % y(2) : uc' il/l
    % dydt(1) : uc' il/l
    % dydt(2) : uc'' ul/l/c
    dydt = zeros(2, 1);
    dydt(1) = y(2);
    dydt(2) = us/l/c - y(1)/l/c - y(2)*r/l;
   
function run_pushbutton_Callback(hObject, eventdata, handles)
    l = handles.metricdata.l;
    c = handles.metricdata.c;
    r = handles.metricdata.r;
    us = handles.metricdata.us;
    uc0 = handles.metricdata.uc0;
    il0 = handles.metricdata.il0;
    
    t_span = [0, 10*r*c];
    y0 = [uc0, il0/c];
    [t, y] = ode45(@(t, y) func_rlc(t, y, r, l, c, us), t_span, y0);
    % uc
    plot(t, y(:, 1));
    % I
    plot(t, c*y(:, 2));
    % ul
    plot(t, us - r*c*y(:,2) - y(:,1));
    legend("uc", "i", "ul");
    
    
function il0_input_Callback(hObject, eventdata, handles)
    handles.metricdata.il0 = str2double(get(hObject, "String"));
    guidata(hObject, handles);
function il0_input_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


function l_input_Callback(hObject, eventdata, handles)
    handles.metricdata.l = str2double(get(hObject, "String"));
    guidata(hObject, handles);
function l_input_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


function uc0_input_Callback(hObject, eventdata, handles)
    handles.metricdata.uc0 = str2double(get(hObject, "String"));
    guidata(hObject, handles);
function uc0_input_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


function c_input_Callback(hObject, eventdata, handles)
    handles.metricdata.c = str2double(get(hObject, "String"));
    guidata(hObject, handles);
function c_input_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


function us_input_Callback(hObject, eventdata, handles)
    handles.metricdata.us = str2double(get(hObject, "String"));
    guidata(hObject, handles);
function us_input_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


function r_input_Callback(hObject, eventdata, handles)
    handles.metricdata.r = str2double(get(hObject, "String"));
    guidata(hObject, handles);
function r_input_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
