# SQL Homework - Employee Database: A Mystery in Two Parts

![sql.png](sql.png)

## Background

It is a beautiful spring day, and it is two weeks since you have been hired as a new data engineer at Pewlett Hackard. Your first major task is a research project on employees of the corporation from the 1980s and 1990s. All that remain of the database of employees from that period are six CSV files.

In this assignment, you will design the tables to hold data in the CSVs, import the CSVs into a SQL database, and answer questions about the data. In other words, you will perform:

1. Data Engineering

3. Data Analysis

Note: You may hear the term "Data Modeling" in place of "Data Engineering," but they are the same terms. Data Engineering is the more modern wording instead of Data Modeling.

### Before You Begin

1. Create a new repository for this project called `sql-challenge`. **Do not add this homework to an existing repository**.

2. Clone the new repository to your computer.

3. Inside your local git repository, create a directory for the SQL challenge. Use a folder name to correspond to the challenge: **EmployeeSQL**.

4. Add your files to this folder.

5. Push the above changes to GitHub.

## Instructions

#### Data Modeling

Inspect the CSVs and sketch out an ERD of the tables. Feel free to use a tool like [http://www.quickdatabasediagrams.com](http://www.quickdatabasediagrams.com).

#### Data Engineering

* Use the information you have to create a table schema for each of the six CSV files. Remember to specify data types, primary keys, foreign keys, and other constraints.

  * For the primary keys check to see if the column is unique, otherwise create a [composite key](https://en.wikipedia.org/wiki/Compound_key). Which takes to primary keys in order to uniquely identify a row.
  * Be sure to create tables in the correct order to handle foreign keys.

* Import each CSV file into the corresponding SQL table. **Note** be sure to import the data in the same order that the tables were created and account for the headers when importing to avoid errors.

#### Data Analysis

Once you have a complete database, do the following:

1. List the following details of each employee: employee number, last name, first name, sex, and salary.

2. List first name, last name, and hire date for employees who were hired in 1986.

3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

4. List the department of each employee with the following information: employee number, last name, first name, and department name.

5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

## Bonus (Optional)

As you examine the data, you are overcome with a creeping suspicion that the dataset is fake. You surmise that your boss handed you spurious data in order to test the data engineering skills of a new employee. To confirm your hunch, you decide to take the following steps to generate a visualization of the data, with which you will confront your boss:

1. Import the SQL database into Pandas. (Yes, you could read the CSVs directly in Pandas, but you are, after all, trying to prove your technical mettle.) This step may require some research. Feel free to use the code below to get started. Be sure to make any necessary modifications for your username, password, host, port, and database name:

   ```sql
   from sqlalchemy import create_engine
   engine = create_engine('postgresql://localhost:5432/<your_db_name>')
   connection = engine.connect()
   ```

* Consult [SQLAlchemy documentation](https://docs.sqlalchemy.org/en/latest/core/engines.html#postgresql) for more information.

* If using a password, do not upload your password to your GitHub repository. See [https://www.youtube.com/watch?v=2uaTPmNvH0I](https://www.youtube.com/watch?v=2uaTPmNvH0I) and [https://help.github.com/en/github/using-git/ignoring-files](https://help.github.com/en/github/using-git/ignoring-files) for more information.

2. Create a histogram to visualize the most common salary ranges for employees.

3. Create a bar chart of average salary by title.

## Epilogue

Evidence in hand, you march into your boss's office and present the visualization. With a sly grin, your boss thanks you for your work. On your way out of the office, you hear the words, "Search your ID number." You look down at your badge to see that your employee ID number is 499942.

## Submission

* Create an image file of your ERD.

* Create a `.sql` file of your table schemata.

* Create a `.sql` file of your queries.

* (Optional) Create a Jupyter Notebook of the bonus analysis.

* Create and upload a repository with the above files to GitHub and post a link on BootCamp Spot.

* Ensure your repository has regular commits (i.e. 20+ commits) and a thorough README.md file

### Copyright

Trilogy Education Services © 2019. All Rights Reserved.


-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/t4EYKY
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Modify this code to update the DB schema diagram.
-- To reset the sample schema, replace everything with
-- two dots ('..' - without quotes).

CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "emp_title_id" varchar(5)   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(255)   NOT NULL,
    "last_name" varchar(255)   NOT NULL,
    "sex" varchar(1)   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "titles" (
    "title_id" varchar(5)   NOT NULL,
    "title" varchar(255)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(4)   NOT NULL
);

CREATE TABLE "departments" (
    "dept_no" varchar(4)   NOT NULL,
    "dept_name" varchar(255)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" varchar(4)   NOT NULL,
    "emp_no" int   NOT NULL
);

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

-- Question 1
select e.emp_no, e.last_name, e.first_name, e.sex, s.salary
from employees as e
inner join salaries as s
on e.emp_no=s.emp_no;

-- Question 2
select first_name, last_name, hire_date from employees
where hire_date between '1986/01/01' and '1986/12/31';


-- Question 3
select d.dept_no,d.dept_name, dm.emp_no, e.last_name, e.first_name
from departments as d, dept_manager as dm, employees as e
where d.dept_no=dm.dept_no
and dm.emp_no=e.emp_no
order by dept_name;

-- Question 4
select e.emp_no, e.last_name, e.first_name,d.dept_name
from employees as e, departments as d, dept_emp
where e.emp_no=dept_emp.emp_no
and dept_emp.dept_no = d.dept_no
order by d.dept_name, e.last_name,e.first_name;

-- Question 5
select first_name, last_name, sex from employees
where first_name = 'Hercules' and last_name like 'B%';


-- Question 6
select e.emp_no, e.last_name,e.first_name,d.dept_name
from employees as e, departments as d, dept_emp
where e.emp_no=dept_emp.emp_no
and dept_emp.dept_no=d.dept_no
and dept_name = 'Sales'
order by e.last_name,e.first_name;


-- Question 7
select e.emp_no, e.last_name,e.first_name,d.dept_name
from employees as e, departments as d, dept_emp
where e.emp_no=dept_emp.emp_no
and dept_emp.dept_no=d.dept_no
and dept_name in ('Sales','Development')
order by d.dept_name,e.last_name,e.first_name;


-- Question 8
select last_name,count(emp_no) as Count from employees
group by last_name
order by Count desc;



### Bonus code in Jupyter Notebook:
{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "from sqlalchemy import create_engine\n",
    "from config import key\n",
    "import matplotlib.pyplot as plt\n",
    "import pandas as pd\n",
    "from sqlalchemy import Column, Integer, String, Float"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "### Connect to Postgres Database"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "metadata": {},
   "outputs": [],
   "source": [
    "rds_connection_string = f\"postgres:{key}@10.0.0.6:5432/employee2\"\n",
    "engine = create_engine(f\"postgresql://{rds_connection_string}\")\n",
    "conn = engine.connect()"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "### Query Database"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "metadata": {},
   "outputs": [],
   "source": [
    "data=pd.read_sql(\"SELECT ROUND(AVG(S.SALARY),2), T.TITLE FROM EMPLOYEES AS E, SALARIES AS S, TITLES AS T WHERE E.EMP_NO=S.EMP_NO AND E.EMP_TITLE_ID=T.TITLE_ID GROUP BY T.TITLE\", conn)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "### Visualize Data for Validation"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/html": [
       "<div>\n",
       "<style scoped>\n",
       "    .dataframe tbody tr th:only-of-type {\n",
       "        vertical-align: middle;\n",
       "    }\n",
       "\n",
       "    .dataframe tbody tr th {\n",
       "        vertical-align: top;\n",
       "    }\n",
       "\n",
       "    .dataframe thead th {\n",
       "        text-align: right;\n",
       "    }\n",
       "</style>\n",
       "<table border=\"1\" class=\"dataframe\">\n",
       "  <thead>\n",
       "    <tr style=\"text-align: right;\">\n",
       "      <th></th>\n",
       "      <th>round</th>\n",
       "      <th>title</th>\n",
       "    </tr>\n",
       "  </thead>\n",
       "  <tbody>\n",
       "    <tr>\n",
       "      <th>0</th>\n",
       "      <td>48564.43</td>\n",
       "      <td>Assistant Engineer</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>1</th>\n",
       "      <td>48535.34</td>\n",
       "      <td>Engineer</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>2</th>\n",
       "      <td>51531.04</td>\n",
       "      <td>Manager</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>3</th>\n",
       "      <td>48506.80</td>\n",
       "      <td>Senior Engineer</td>\n",
       "    </tr>\n",
       "    <tr>\n",
       "      <th>4</th>\n",
       "      <td>58550.17</td>\n",
       "      <td>Senior Staff</td>\n",
       "    </tr>\n",
       "  </tbody>\n",
       "</table>\n",
       "</div>"
      ],
      "text/plain": [
       "      round               title\n",
       "0  48564.43  Assistant Engineer\n",
       "1  48535.34            Engineer\n",
       "2  51531.04             Manager\n",
       "3  48506.80     Senior Engineer\n",
       "4  58550.17        Senior Staff"
      ]
     },
     "execution_count": 4,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "data.head()"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "### Creates Data structure to create bar chart"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "metadata": {},
   "outputs": [],
   "source": [
    "group=data.groupby(['title']).agg(['max'])"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "### Creates Bar Chart of Average Salaries by Title"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "(array([0, 1, 2, 3, 4, 5, 6]), <a list of 7 Text xticklabel objects>)"
      ]
     },
     "execution_count": 8,
     "metadata": {},
     "output_type": "execute_result"
    },
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAAAZwAAAFWCAYAAABdMivrAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEgAACxIB0t1+/AAAADh0RVh0U29mdHdhcmUAbWF0cGxvdGxpYiB2ZXJzaW9uMy4xLjMsIGh0dHA6Ly9tYXRwbG90bGliLm9yZy+AADFEAAAgAElEQVR4nOzdebzWc/7/8cezvZBKMQiFLEmUKHtEEqNk3woRxjYGIzPzUxnrjK+lmbE0ZI3sy5ioLNlJYbJPMejYlSVEqtfvj9f7qstxzumcOtfnOsvrfrtdt3N93tfnuj7vazmf1+e9y8wIIYQQCq1BsTMQQgihfoiAE0IIIRMRcEIIIWQiAk4IIYRMRMAJIYSQiQg4IYQQMhEBJ4QikDRF0jEr8PzXJfWuxiwh6T1Ju1Xna5ZznArzvqKfTai5IuCEzKQTyZeSmhY7L9VB0maSJqX39JWk6ZL6Z3FsM9vMzKZkcayqkHSYpG/Tbb6kxXnb38LP8y5ppKRbiprpkJkIOCETkjoAOwIG7FOgYzQqxOtW4F/AZGANYHXgFOCbQh6wCO+xSsxsnJmtbGYrA3sCH+W2U1qoxyLghKwMBp4HbgCG5BIl9ZL0iaSGeWn7SpqR7jeQNFzSO5LmSLpDUpv0WAdJJmmopA+Ax1L6nek1v5b0pKTN8l57NUn/kvSNpBclnSfp6bzHN5E0WdJcSW9LOrCsNyOpLdAR+KeZLUi3Z8zs6fR4a0kPSvo8lYAelNS+nNfaQNJj6f19IWmcpFZ5j78n6az0mXwnqVF+9dcyPqNmkm5J6V+l97xGBd/T1pLeSHm+XlKz9DqvSfp1Xp4ap7xuWcFrlSmXd0n9gD8AB6US0H/K2f9oSW+mPE2UtF5Vjxlqhgg4ISuDgXHptkfupGdmzwPfAbvm7XsocGu6fwowENgZWAv4EvhHqdfeGdgU2CNtPwR0wksdL6Vj5vwjHe9XeODLD34r4SWWW9NzDwGuzA9YeeYAs4BbJA0s4yTeALgeWA9YF5gP/L2M1wEQcGF6f5sC6wAjS+1zCLAX0MrMFpZ6rKLPaAiwanrN1YDjU17Kcxj+OW4AbAT8KaXfBByet19/4GMze6WC16qQmT0MXADcnkpAW5TeR9JAPCgNAtoBTwG3Le8xQ5GZWdziVtAbsAPwE9A2bb8FnJb3+HnA2HR/FTwgrJe23wT65O27ZnqtRkAHvIpu/QqO3SrtsyrQMD1341LHfjrdPwh4qtTzrwFGlPPa7fEg8g6wGHgS6FTOvlsCX+ZtTwGOKWffgcDLedvvAUeX2uc9YLdKfEZHA88CXSvxPb0HHJ+33R94J91fC5gHtEzbdwG/X8br9QZKyjlOLu8jgVtKPb7ks8EvHobmPdYA+D73+4hb7bpFCSdkYQgwycy+SNu3kleySNuDUmeCQcBLZvZ+emw94N5UHfQVfnJdhLeb5MzO3ZHUUNJFqXrpG/zkBtAWv0JulL9/qfvrAT1zx0rHOwwvDf2CmZWY2UlmtkF67nd4SQBJLSRdI+n9lI8ngVb5VYd5eV5d0nhJH6Z9b0n5zTe79PNK5bu8z+hmYCIwXtJHkv4iqXEFr5V/nPfxQIOZfQQ8A+yXqvv25Oclx0JZD7gi773NxUuEa2dw7FDNanQDZKj9JDUHDgQaSvokJTfFT75bmNl/zOwNSe/jJ7H86jTwE+DRZvZMGa/dId3Nn/L8UGAAsBsebFbFq5gEfA4sxEsm/037r1PqWE+Y2e5VfZ9mNlvSP1ha3XM6sDHQ08w+SW0dL6d8lHZheg9dzWxOqkYqXf1W0bTu5X5GyShgVPq8JgBvA9eVs2/+57Eu8FHe9o3AMfh54zkz+7CCPFXWsqarnw2cb2ZZBLdQYFHCCYU2EL/a7oxXK22Jt1M8hbfr5NyKt0XsBNyZl341cH6uoVhSO0kDKjjeKsCPeBtLC7yNAAAzWwTcA4xMJZBNSuXhQWAjSUekRvHGkraWtGnpg6ROAaMkbZga7dvi1VfP5+VjPvBVasAfsYw8f5v2XRs4s4J9y1LuZyRpF0mbp5LVN3hV26IKXutESe1Tnv8A3J732H1Ad+BUUkmuGnwKdJBU3rnoauDsXDuapFUlHVBNxw4Zi4ATCm0IcL2ZfWBmn+Ru+BX8YVrazfc2vM7/sbyqN4ArgAeASZLm4Sf0nhUc7ya8KuhD4A2WBoCck/BSzyd4ddNteIDCzOYBfYGD8Sv7T4CL8RJZaQvwNqRH8BP5a+l1jkyPXw40B75IeXi4gjyPwk/kXwP/xoNiVVT0Gf0Kb2/5Bq9qewKvsivPrcAk4N10Oy/3gJnNB+7Ge+dVNY/lyV1czJH0UukHzexe/DsYn6obX8NLwqEWklkswBbqL0kXA78ysyHL3Dkg6RxgIzM7fJk7h1BKlHBCvSIfZ9NVbhtgKHBvsfNVG6RqtqHAmGLnJdROEXBCfbMKXh30HXAH8H/A/UXNUS0g6Vi8Af8hM3uy2PkJtVNUqYUQQshElHBCCCFkIgJOCCGETNS7gZ9t27a1Dh06FDsbIYRQa0yfPv0LM2u3oq9T0ICTpsC4FuiCjyg+Gh/lfDs+huE94EAz+1KS8PEE/fG5ko40s5fS6wxh6SSC55nZjSl9K3z24eb4COpTbRmNUh06dGDatGnV9yZDCKGOSzOBrLBCV6ldATxsZpsAW+ADz4YDj5pZJ+DRtA0+mKtTug0DroIlXTFH4APZtgFGSGqdnnNV2jf3vH4Ffj8hhBCWU8ECjqSW+DQl1wGYrxfyFT7P1Y1ptxvxqU9I6TeZex6fa2tNfKr0yWY218y+xKeP75cea2lmz6VSzU15rxVCCKGGKWQJZ318ssTrJb0s6dq03sgaZvYxQPq7etp/bX4+U21JSqsovaSM9BBCCDVQIdtwGuHzQ51sZi9IuoKl1WdlKWsWXVuO9F++sDQMr3pj3XXX/cXjP/30EyUlJfzwww8VZC9koVmzZrRv357GjSuaQT+EUBsVMuCU4IsvvZC278IDzqeS1jSzj1O12Gd5++dPjd4en0CxBJ/UMT99SkpvX8b+v2BmY0jTcfTo0eMXQamkpIRVVlmFDh064H0XQjGYGXPmzKGkpISOHTsWOzshhGpWsCq1NCPwbEkbp6Q++Oy9D7B08a0hLJ1W5AFgcJrjqhfwdapymwj0TdPBt8Zn852YHpsnqVfq4TaY5Zyi5IcffmC11VaLYFNkklhttdWipBlCHVXocTgnA+MkNcGnOj8KD3J3SBoKfADk1raYgHeJnoV3iz4KwMzmSvoz8GLa71wzm5vun8DSbtEPpdtyiWBTM8T3EELdVdBu0Wb2ipn1MLOuZjbQzL40szlm1sfMOqW/c9O+ZmYnmtkGZra5mU3Le52xZrZhul2flz7NzLqk55y0rDE4xSCJ008/fcn2JZdcwsiRIwt6zA4dOrDffvst2b7rrrs48sgjC3rMEEJYlpjapsCaNm3KPffcwxdffLHsnavRtGnTeP311zM9ZgghVKTeTW2TtUaNGjFs2DAuu+wyzj///J899v7773P00Ufz+eef065dO66//nrWXXddjjzySFq2bMm0adP45JNP+Mtf/sL+++8PwF//+lfuuOMOfvzxR/bdd19GjRpV5nHPOOMMLrjgAsaN+/lS8HPnzuXoo4/m3XffpUWLFowZM4auXbsycuRIPvjgA959910++OADfvvb33LKKacAcMsttzB69GgWLFhAz549ufLKK2nYsGEBPq1Qk3QY/u+Cvv57F+1V0Nev7fmvi6KEk4ETTzyRcePG8fXXX/8s/aSTTmLw4MHMmDGDww47bMkJHuDjjz/m6aef5sEHH2T4cO9NPmnSJGbOnMnUqVN55ZVXmD59Ok8+WfbSJAceeCAvvfQSs2bN+ln6iBEj6NatGzNmzOCCCy5g8ODBSx576623mDhxIlOnTmXUqFH89NNPvPnmm9x+++0888wzvPLKKzRs2PAXQSyEECojSjgZaNmyJYMHD2b06NE0b958Sfpzzz3HPff40vBHHHEEv//975c8NnDgQBo0aEDnzp359NNPAQ84kyZNolu3bgB8++23zJw5k5122ukXx2zYsCFnnnkmF154IXvuuXQJ+Keffpq7774bgF133ZU5c+YsCYR77bUXTZs2pWnTpqy++up8+umnPProo0yfPp2tt94agPnz57P66qv/4nghhLAsEXAy8tvf/pbu3btz1FFHlbtPfg+tpk2bLrmf6wthZpx99tkcd9xxlTrmEUccwYUXXshmm232i9cq67j5x2zYsCELFy7EzBgyZAgXXnhhpY4ZQgjliSq1jLRp04YDDzyQ6667bknadtttx/jx4wEYN24cO+ywQ4WvscceezB27Fi+/fZbAD788EM++8zHzfbp04cPP/zwZ/s3btyY0047jcsvv3xJ2k477bSkSmzKlCm0bduWli1blnvMPn36cNdddy05zty5c3n//WqZODaEUM9EwMnQ6aef/rPeaqNHj+b666+na9eu3HzzzVxxxRUVPr9v374ceuihbLvttmy++ebsv//+zJs3j8WLFzNr1izatGnzi+cMHTqUhQsXLtkeOXIk06ZNo2vXrgwfPpwbb7zxF8/J17lzZ8477zz69u1L165d2X333fn444+r+M5DCAFUA4euFFSPHj2s9Ho4b775JptuummRcrTiXnvtNcaOHcull15a7KxUi9r+fdQVtb2XV23Pf00iabqZ9VjR14kSTh3QpUuXOhNsQgh1VwScEEIImYiAE0IIIRMRcEIIIWQiAk4IIYRMRMAJIYSQiQg4IYQQMhFT25ShuvvvV6a//vz58+nXrx+PPfZYpjMx9+7dm0suuYQePVa4i32VLFiwgN12243HHnuMRo3iZxhCfRAlnBpi7NixDBo06BfBZtGiRUXKUWE1adKEPn36cPvttxc7KyGEjETAqSHGjRvHgAEDAJ/jbJddduHQQw9l8803B+DSSy+lS5cudOnSZcncaO+99x5dunRZ8hr5q4n27t2bs846i2222YaNNtqIp556CvCS1MEHH0zXrl056KCDmD9//jLz1rt3b0477TR22mknNt10U1588UUGDRpEp06d+NOf/rRkv4EDB7LVVlux2WabMWbMGMDX/OnUqRNffPEFixcvZscdd2TSpElL9o+lDkKoP6IuowZYsGAB7777Lh06dFiSNnXqVF577TU6duzI9OnTuf7663nhhRcwM3r27MnOO+9M69atK3zdhQsXMnXqVCZMmMCoUaN45JFHuOqqq2jRogUzZsxgxowZdO/evVJ5bNKkCU8++SRXXHEFAwYMYPr06bRp04YNNtiA0047jdVWW42xY8fSpk0b5s+fz9Zbb81+++3Heuutx1lnncXxxx9Pz5496dy5M3379gV8hoQXX3xxuT+3EELtEiWcGuCLL76gVatWP0vbZptt6NixI+Br2Oy7776stNJKrLzyygwaNGhJiaUigwYNAmCrrbbivffeA+DJJ5/k8MMPB6Br16507dq1UnncZ599ANh8883ZbLPNWHPNNWnatCnrr78+s2fPBnwy0i222IJevXoxe/ZsZs6cCcAxxxzDvHnzuPrqq7nkkkuWvGbDhg1p0qQJ8+bNq1QeQgi1W5RwaoDmzZvzww8//CxtpZVWWnK/vAlWGzVqxOLFi5dsl36N3Po2ubVtcvLX3ams3Gs1aNDgZ+vmNGjQgIULFzJlyhQeeeQRnnvuOVq0aEHv3r2X5Of777+npKQE8EXjVllllSXP//HHH2nWrFmV8xNCqH2ihFMDtG7dmkWLFv0iYOTstNNO3HfffXz//fd899133Hvvvey4446sscYafPbZZ8yZM4cff/yRBx98cJnHyl8P57XXXmPGjBlLHhs8eDBTp05drvfw9ddf07p1a1q0aMFbb73F888/v+Sxs846i8MOO4xzzz2XY489dkn6nDlzaNeuHY0bN16uY4YQapco4ZShGNOO9+3bl6effprd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\n",
      "text/plain": [
       "<Figure size 432x288 with 1 Axes>"
      ]
     },
     "metadata": {
      "needs_background": "light"
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "barplot=group.plot(kind='bar',title='Average Salaries by Title')\n",
    "barplot.set_xlabel('Titles')\n",
    "barplot.set_ylabel('Average Salary')\n",
    "plt.show\n",
    "plt.xticks(rotation=45)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "### Creates Histogram of Salaries"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "array([[<matplotlib.axes._subplots.AxesSubplot object at 0x000002437CEB9A88>]],\n",
       "      dtype=object)"
      ]
     },
     "execution_count": 11,
     "metadata": {},
     "output_type": "execute_result"
    },
    {
     "data": {
      "image/png": "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\n",
      "text/plain": [
       "<Figure size 432x288 with 1 Axes>"
      ]
     },
     "metadata": {
      "needs_background": "light"
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Source: https://mode.com/example-gallery/python_histogram/\n",
    "\n",
    "# Query database tables to retrieve salary data\n",
    "salaries=pd.read_sql(\"SELECT SALARY FROM SALARIES\", conn)\n",
    "\n",
    "# Creates histogram\n",
    "salaries.hist(column='salary')"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "metadata": {},
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.7.6"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 4
}
