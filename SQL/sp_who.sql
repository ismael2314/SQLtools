SELECT sid = er.session_id,  
 status = ses.status,  
  [user] = ses.login_name,  
  host = ses.host_name,  
  program = ses.program_name,  
  blkBy = er.blocking_session_id,  
  dbName = Db_name(er.database_id),  
  commandType = er.command,  
  objectName  = Object_name(st.objectid),  
  cpuTime = er.cpu_time,  
  startTime = er.start_time,  
  timeElapsed = Cast(Getdate() - er.start_time AS TIME),  
  statement = st.text  
FROM sys.dm_exec_requests er  
           OUTER apply sys.Dm_exec_sql_text(er.sql_handle) st  
           LEFT JOIN sys.dm_exec_sessions ses  
                     ON ses.session_id = er.session_id  
  LEFT JOIN sys.dm_exec_connections con  
                     ON con.session_id = ses.session_id  
WHERE st.text IS NOT NULL  
order by startTime
