function varargout = TimeDomain(varargin)
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @TimeDomain_OpeningFcn, ...
                       'gui_OutputFcn',  @TimeDomain_OutputFcn, ...
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


% --- Executes just before TimeDomain is made visible.
function TimeDomain_OpeningFcn(hObject, eventdata, handles, varargin)
    handles.output = hObject;

    guidata(hObject, handles);
    
    
function varargout = TimeDomain_OutputFcn(hObject, eventdata, handles) 
    varargout{1} = handles.output;


function rc_button_Callback(hObject, eventdata, handles)
    close();
    level1_rc();

    
function rl_button_Callback(hObject, eventdata, handles)
    level1_rl();

function rcl_button_Callback(hObject, eventdata, handles)
    level2_rlc();


function gcl_button_Callback(hObject, eventdata, handles)
    level2_glc();
