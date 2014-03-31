declare 
 job user_jobs.job%TYPE;
 
 CURSOR c IS
    select job from user_jobs;
begin
    OPEN c;
    LOOP
        fetch c into job;
        exit when c%NOTFOUND;

        dbms_output.put_line('Removing job: '||job);
        dbms_job.remove(job);
    END LOOP;
    CLOSE c;

    commit;
end;
