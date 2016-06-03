@mod @mod_quiz @task_fields
Feature: Some test from OASychev

  Background:

  Given the following "courses" exist:
      | fullname | shortname | category |
      | course1  | C1        | 0        |

    And the following "users" exist:
      | username | firstname | lastname | email              |
      | teacher1 | teacher1  | Teacher1 | teacher1@example.com |
      | user1 | user1      | Teacher1 | student1@example.com |
      | user2 | user2      | Student1 | student2@example.com |
      | user3 | user3      | Student2 | student3@example.com |
      | user4 | user4      | Student3 | student4@example.com |

    And the following "groups" exist:
      | name    | description | course  | idnumber |
      | group1 | Anything    | C1 | GROUP1   |
      | group2 | Anything    | C1 | GROUP2   |

    And the following "group members" exist:
      | user     | group  |
      | user1    | GROUP1 |
      | user2    | GROUP1 |
      | user3    | GROUP2 |

    And the following "course enrolments" exist:
      | user     | course | role |
      | teacher1 | C1     | editingteacher |
      | user1 | C1     | student |
      | user2 | C1     | student |
      | user3 | C1     | student |
      | user4 | C1     | student |

    And the following "activities" exist:
      | activity   | name   | intro   | course | idnumber | groupmode |
      | quiz       | quiz1  | quiz1  | C1     | quiz1    | 2  |

    And the following "questions" exist:
      | qtype       | name  | questiontext             | defaultmark |
      | truefalse   | q1    | do you like our course?  | 1           |
      | truefalse   | q2    | 2+2=?                    | 1           |

    #############

  Given I log in as "user1"
    And I follow "quiz1"
    And I press "Attempt quiz now"
    And I click on "True" "radio" in the "q1" "question"
    And I click on "False" "radio" in the "q2" "question"
    And I log out

    Given I log in as "user4"
    And I follow "quiz1"
    And I press "Attempt quiz now"
    And I click on "True" "radio" in the "q1" "question"
    And I click on "True" "radio" in the "q2" "question"
    And I log out

  Given I log in as "teacher1"
    And I follow "quiz1"
    And I select "Not a members of any group" from the "group" singleselect

    Scenario: make sure that number of attempts in the top of page equals '2 (1 from this group)',
    labels on bottom after the form say 'full regrade for not members of any group' and 'dry run full regrade for not members of any group', in the table next there are only 'user4' results appear, name of the first graph is 'number of students who are not members of any group achieving grade ranges' and graph shows one participant with grade 2.
    And I click on "Grades" "link" in the "ADMINISTRATION" "block"
      And  I should see "Attempts: 2"
      And "full regrade for not members of any group" "button" should exist
      And "dry run full regrade for not members of any group" "button" should exits
