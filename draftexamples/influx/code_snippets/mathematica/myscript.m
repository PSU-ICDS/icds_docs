outputlogfile = OpenWrite["m_output.log", FormatType -> OutputForm];
$PrePrint = (Write[outputlogfile, #]; #) &;

printlogfile = OpenWrite["m_print.log", FormatType -> StandardForm];
AppendTo[$Output, printlogfile];

messageslogfile = OpenWrite["m_messages.log", FormatType -> OutputForm];
AppendTo[$Messages, messageslogfile];

(* ------- Only these 2 lines are needed if no monitoring is needed *) 
SetOptions[First[$Output],FormatType->StandardForm];
UsingFrontEnd[NotebookEvaluate["mynotebook.nb",InsertResults->True]] 
(* ------- *)

  Close[messageslogfile];$Messages=$Messages[[{1}]];
Close[printlogfile];$Output=$Output[[{1}]];
Close[outputlogfile];
