{% test est_timezone_offset(model, column_name) %}
    select *
    from {{ model }}
    where 
      case 
        when date_part(month, {{ column_name }}) between 3 and 10 -- Daylight Savings
          then {{ column_name }} != dateadd(hour, -4, {{ column_name[:-4] }})
        else {{ column_name }} != dateadd(hour, -5, {{ column_name[:-4] }})
      end
{% endtest %}