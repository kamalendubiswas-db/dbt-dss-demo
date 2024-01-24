{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    {%- if custom_schema_name is none -%}

        {{ default_schema }}

    {%- else -%}
        {%- if ( var('schema_prefix', none) is not none
            and var('schema_prefix')|length ) -%}

            {%- set schema_prefix = var('schema_prefix') -%}

            {{ schema_prefix }}_{{ custom_schema_name | trim }}
        
        {%- else -%}

            {{ custom_schema_name | trim }}

        {%- endif -%}
    
    {%- endif -%}
{%- endmacro %}
