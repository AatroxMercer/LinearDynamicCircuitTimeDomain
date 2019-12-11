function varargout = level1_rc(varargin)
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @level1_rc_OpeningFcn, ...
                       'gui_OutputFcn',  @level1_rc_OutputFcn, ...
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


% --- Executes just before level1_rc is made visible.
function level1_rc_OpeningFcn(hObject, eventdata, handles, varargin)
    handles.output = hObject;   

    hold on
    grid on
    handles.metricdata.r = 0;
    handles.metricdata.c = 0;
    handles.metricdata.tc = 0;
    handles.metricdata.final = 0;
    handles.metricdata.initial = 0;
    
    % Update handles structure
    guidata(hObject, handles);

    % UIWAIT makes level1_rc wait for user response (see UIRESUME)
    % uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = level1_rc_OutputFcn(hObject, eventdata, handles)
    varargout{1} = handles.output;


function c_input_Callback(hObject, eventdata, handles)
    handles.metricdata.c = str2double(get(hObject, "String"));
    handles.metricdata.tc = handles.metricdata.c * handles.metricdata.r;
    set(handles.tc_text, "String", handles.metricdata.tc);
    guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function c_input_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end



function r_input_Callback(hObject, eventdata, handles)
    handles.metricdata.r = str2double(get(hObject, "String"));
    handles.metricdata.tc = handles.metricdata.c * handles.metricdata.r;
    
    set(handles.tc_text, "String", handles.metricdata.tc);
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function r_input_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


% --------------------------------------------------------------------
function menu_rc_Callback(hObject, eventdata, handles)



function final_input_Callback(hObject, eventdata, handles)
    handles.metricdata.final = str2double(get(hObject, "String"));
    guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function final_input_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end



function initial_input_Callback(hObject, eventdata, handles)
    handles.metricdata.initial = str2double(get(hObject, "String"));
    guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function initial_input_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end


% --- Executes on button press in drawPushbutton.
function drawPushbutton_Callback(hObject, eventdata, handles)
    tc = handles.metricdata.tc;
    final = handles.metricdata.final;
    initial = handles.metricdata.initial;
    
    t = 0:0.01:10;
    u = final + (initial - final) * exp(- t / tc);
    plot(handles.axes, t, u);

% --- Executes on button press in resetPushbutton.
function resetPushbutton_Callback(hObject, eventdata, handles)
    refresh(hObject, handles);

% return to the orginal status
function refresh(hObject, handles)
    handles.metricdata.tc = 0;
    handles.metricdata.r = 0;
    handles.metricdata.c = 0;
    handles.metricdata.final = 0;
    handles.metricdata.initial = 0;
    
    set(handles.tc_text, "String", handles.metricdata.tc);
    set(handles.r_input, "String", handles.metricdata.r);
    set(handles.c_input, "String", handles.metricdata.c);
    set(handles.final_input, "String", handles.metricdata.final);
    set(handles.initial_input, "String", handles.metricdata.initial);
    
    % clear the axes
    cla(handles.axes);
    
    guidata(hObject, handles);
    
