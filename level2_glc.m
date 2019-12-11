function varargout = level2_glc(varargin)
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @level2_glc_OpeningFcn, ...
                       'gui_OutputFcn',  @level2_glc_OutputFcn, ...
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


function level2_glc_OpeningFcn(hObject, eventdata, handles, varargin)
    handles.output = hObject;
    
    axes(handles.axes);
    hold on
    grid on
    
    handles.metricdata.l = 0;
    handles.metricdata.c = 0;
    handles.metricdata.r = 0;
    handles.metricdata.is = 0;
    handles.metricdata.uc0 = 0;
    handles.metricdata.il0 = 0;
    
    guidata(hObject, handles);

function varargout = level2_glc_OutputFcn(hObject, eventdata, handles) 
    varargout{1} = handles.output;


function reset_pushbutton_Callback(hObject, eventdata, handles)
    cla(handles.axes);

    handles.metricdata.l = 0;
    handles.metricdata.c = 0;
    handles.metricdata.r = 0;
    handles.metricdata.is = 0;
    handles.metricdata.uc0 = 0;
    handles.metricdata.il0 = 0;
    
    set(handles.l_input, "String", handles.metricdata.l);
    set(handles.c_input, "String", handles.metricdata.c);
    set(handles.r_input, "String", handles.metricdata.r);
    set(handles.is_input, "String", handles.metricdata.is);
    set(handles.uc0_input, "String", handles.metricdata.uc0);
    set(handles.il0_input, "String", handles.metricdata.il0);
    
    guidata(hObject, handles);
    
    
% https://www.zybang.com/question/76ec3e7e695418a90dac559ebfb0b8ee.html
function dydt = func_glc(t, y, g, l, c, is)
    % y(1) : il
    % y(2) : il' ul/l
    % dydt(1) : il' ul/l
    % dydt(2) : il'' ic/l/c
    dydt = zeros(2, 1);
    dydt(1) = y(2);
    dydt(2) = is/l/c - y(1)/l/c - y(2)*g/c;
   
function run_pushbutton_Callback(hObject, eventdata, handles)
    l = handles.metricdata.l;
    c = handles.metricdata.c;
    g = 1 / handles.metricdata.r;
    is = handles.metricdata.is;
    uc0 = handles.metricdata.uc0;
    il0 = handles.metricdata.il0;
    
    t_span = [0, 10*c/g];
    y0 = [il0, uc0/l];
    [t, y] = ode45(@(t, y) func_glc(t, y, g, l, c, is), t_span, y0);
    % il
    plot(t, y(:, 1));
    % u
    plot(t, l*y(:, 2));
    % 
    plot(t, is - g*l*y(2) - y(1));
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


function is_input_Callback(hObject, eventdata, handles)
    handles.metricdata.is = str2double(get(hObject, "String"));
    guidata(hObject, handles);
function is_input_CreateFcn(hObject, eventdata, handles)
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
