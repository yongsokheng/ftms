namespace :db do
  desc "remake database data"
  task remake_data: :environment do
    Rake::Task["db:migrate:reset"].invoke

    puts "Create Universities"
    ["Vietnam National University, Hanoi", "Hanoi University of Science and Technology",
      "Foreign Trade University",
      "Posts and Telecommunications Institute of Technology",
      "Hanoi University of Industry"].each do |name|
      University.create! name: name
    end

    puts "Create Programming Languages"
    ["Ruby", "PHP", "Android", "Java", "iOS"].each do |name|
      ProgrammingLanguage.create! name: name
    end

    puts "Create User Types"
    ["Intern", "VPG", "JPG", "New dev", "QA"].each do |name|
      UserType.create! name: name
    end

    puts "Create Status"
    ["Inprogress", "Finish", "Prepare project", "Jointed project"].each do |name|
      Status.create! name: name
    end

    puts "Creating Role"
    Role.create! name: "admin", role_type: 0
    Role.create! name: "trainer", role_type: 1
    Role.create! name: "trainee", role_type: 2

    puts "Creating User"
    User.create!([
      {name: "Chu Anh Tuấn", avatar: File.open(File.join(Rails.root,
        "app/assets/images/user/chu_anh_tuan.jpg")),
        email: "chu.anh.tuan@framgia.com", password: "12345678",
        password_confirmation: "12345678"},
      {name: "Nguyễn Bình Diệu", avatar: File.open(File.join(Rails.root,
        "app/assets/images/user/nguyen_binh_dieu.jpg")),
        email: "nguyen.binh.dieu@framgia.com", password: "12345678",
        password_confirmation: "12345678"},
      {name: "Mai Tuấn Việt", avatar: File.open(File.join(Rails.root,
        "app/assets/images/user/mai_tuan_viet.jpg")),
        email: "mai.tuan.viet@framgia.com", password: "12345678",
        password_confirmation: "12345678"},
      {name: "Hoàng Nhạc Trung", avatar: File.open(File.join(Rails.root,
        "app/assets/images/user/hoang_nhac_trung.jpg")),
        email: "hoang.nhac.trung@framgia.com", password: "12345678",
        password_confirmation: "12345678"},
      {name: "Nguyễn Tiến Trung", avatar: File.open(File.join(Rails.root,
        "app/assets/images/user/nguyen_tien_trung.jpg")),
        email: "nguyen.tien.trung@framgia.com", password: "12345678",
        password_confirmation: "12345678"},
      {name: "Hoàng Thị Nhung", avatar: File.open(File.join(Rails.root,
        "app/assets/images/user/hoang_thi_nhung.jpg")),
        email: "hoang.thi.nhung@framgia.com", password: "12345678",
        password_confirmation: "12345678"},
      {name: "Nguyễn Văn Trần Anh", avatar: File.open(File.join(Rails.root,
        "app/assets/images/user/nguyen_van_tran_anh.jpg")),
        email: "nguyen.van.tran.anh@framgia.com", password: "12345678",
        password_confirmation: "12345678"},
      {name: "Trần Xuân Thắng", avatar: File.open(File.join(Rails.root,
        "app/assets/images/user/tran_xuan_thang.jpg")),
        email: "tran.xuan.thang@framgia.com", password: "12345678",
        password_confirmation: "12345678"},
      {name: "Bùi Khánh Huyền", avatar: File.open(File.join(Rails.root,
        "app/assets/images/user/bui_khanh_huyen.jpg")),
        email: "bui.khanh.huyen@framgia.com", password: "12345678",
        password_confirmation: "12345678",
        created_at: "01/07/2016".to_date, updated_at: "01/07/2016".to_date},
      {name: "Chử Kim Thắng", avatar: File.open(File.join(Rails.root,
        "app/assets/images/user/chu_kim_thang.jpg")),
        email: "chu.kim.thang@framgia.com", password: "12345678",
        password_confirmation: "12345678",
        created_at: "08/08/2016".to_date, updated_at: "08/08/2016".to_date},
      {name: "Lê Văn Chiến", avatar: File.open(File.join(Rails.root,
        "app/assets/images/user/le_van_chien.jpg")),
        email: "le.van.chien@framgia.com", password: "12345678",
        password_confirmation: "12345678",
        created_at: "01/09/2016".to_date, updated_at: "01/09/2016".to_date},
      {name: "Nguyễn Thùy Dương", avatar: File.open(File.join(Rails.root,
        "app/assets/images/user/nguyen_thuy_duong.jpg")),
        email: "nguyen.thuy.duong@framgia.com", password: "12345678",
        password_confirmation: "12345678",
        created_at: "01/07/2016".to_date, updated_at: "01/07/2016".to_date},
      {name: "Ninh Đức Quyền", avatar: File.open(File.join(Rails.root,
        "app/assets/images/user/ninh_duc_quyen.jpg")),
        email: "ninh.duc.quyen@framgia.com", password: "12345678",
        password_confirmation: "12345678",
        created_at: "01/07/2016".to_date, updated_at: "01/07/2016".to_date},
      {name: "Vũ Hữu Tuấn ", avatar: File.open(File.join(Rails.root,
        "app/assets/images/user/vu_huu_tuan.jpg")),
        email: "vu.huu.tuan@framgia.com", password: "12345678",
        password_confirmation: "12345678",
        created_at: "01/09/2016".to_date, updated_at: "01/09/2016".to_date},
    ])

    puts "Creating Roles Manager && Trainer"
    User.first.user_roles.create! role_id: 1
    User.first.user_roles.create! role_id: 2
    User.first.user_roles.create! role_id: 3
    User.second.user_roles.create! role_id: 1
    User.find(3).user_roles.create! role_id: 1
    User.find(4).user_roles.create! role_id: 1
    User.find(5).user_roles.create! role_id: 2
    User.find(6).user_roles.create! role_id: 2
    User.find(7).user_roles.create! role_id: 2
    User.find(8).user_roles.create! role_id: 2

    puts "Creating Location Manager && Trainer"
    Location.create! name: "Keangnam", user_id: 2
    Location.create! name: "Laboratory", user_id: 3
    Location.create! name: "Da Nang", user_id: 4

    puts "Create admin, trainer location"
    User.first.create_profile location_id: 1
    User.second.create_profile location_id: 1
    User.find(3).create_profile location_id: 2
    User.find(4).create_profile location_id: 3
    User.find(5).create_profile location_id: 2
    User.find(6).create_profile location_id: 1
    User.find(7).create_profile location_id: 3
    User.find(8).create_profile location_id: 1

    puts "Creating User Roles, Profile && Location"
    User.offset(8).each do |user|
      user.user_roles.create! role_id: 3
      trainer = User.find_by_id 5
      user.update_attributes trainer: trainer
      user.create_profile(
        location_id: 2)
    end

    puts "Creating Evaluation Template"
    ["Working days", "Number of task",
      "Implement with new techniques", "Git", "Rails basic",
      "Rails advance", "Coding convention", "Plus"].each do |name|
      EvaluationTemplate.create! name: name, min_point: 1, max_point: 5
    end

    puts "Create Course"
    Course.create!([
      {name: "Ruby on Rails",
        image: File.open(File.join(Rails.root, "app/assets/images/course/Rails_1.png")),
        description: "Learn more Rails with this sequel to the infamous Rails for Zombies course. Increase your Ruby on Rails knowledge with even more zombie learning.",
        status: 1, programming_language_id: 1, start_date: Time.now, end_date: Time.now + Settings.during_time.course.days},

      {name: "Android",
        image: File.open(File.join(Rails.root, "app/assets/images/android.png")),
        description: "This tutorial will teach you basic Android programming and will also take you through some advance concepts related to Android application development.",
        status: 0, programming_language_id: 1, start_date: Time.now, end_date: Time.now + Settings.during_time.course.days},

      {name: "PHP",
        image: File.open(File.join(Rails.root, "app/assets/images/php.png")),
        description: "PHP is a server scripting language, and a powerful tool for making dynamic and interactive Web pages",
        status: 1, programming_language_id: 1, start_date: Time.now, end_date: Time.now + Settings.during_time.course.days},
    ])

    puts "Create Subject"
    Subject.create!([
      {name: "Ruby on Rails Tutorial Book", image: File.open(File.join(Rails.root,
        "app/assets/images/subject/try_ruby.png")),
        description: "Learn the basic building blocks of Ruby, all in the browser.\r\n",
        content: "<p>Get an introduction to numbers, Strings, properties, and methods,&nbsp;
          Learn about conversions, arrays, variables, and more methods</p>\r\n", during_time: Settings.during_time.tutorial_book},
      {name: "Ruby's Project 1", image: File.open(File.join(Rails.root,
        "app/assets/images/subject/Rails_2.png")),
        description: "Start Project 1 for Ruby on Rails today.\r\n",
        content: "<p>Get an introduction to redmine, requirement, design database</p>\r\n", during_time: Settings.during_time.project_1},
      {name: "Ruby's Project 2", image: File.open(File.join(Rails.root,
        "app/assets/images/ruby.png")),
        description: "Start Project 2 for Ruby on Rails today.\r\n",
        content: "<p>Get an introduction to redmine, requirement, design database</p>\r\n", during_time: Settings.during_time.project_2},

      {name: "Git Tutorial", image: File.open(File.join(Rails.root,
        "app/assets/images/subject/try_git.png")),
        description: "Start Git for your project today.\r\n",
        content: "<p>Get an introduction to github, code version management</p>\r\n", during_time: Settings.during_time.git_tutorial},

      {name: "Android Tutorial Book", image: File.open(File.join(Rails.root,
        "app/assets/images/android.png")),
        description: "This tutorial will teach you basic Android programming and will also take you through some advance concepts related to Android application development.\r\n",
        content: "<p>Get an introduction to numbers, Strings, properties, and methods,&nbsp;
          Learn about conversions, arrays, variables, and more methods</p>\r\n", during_time: Settings.during_time.tutorial_book},
      {name: "Android's Project 1", image: File.open(File.join(Rails.root,
        "app/assets/images/android.png")),
        description: "Start Project 1 for Android today.\r\n",
        content: "<p>Get an introduction to redmine, requirement, design database</p>\r\n", during_time: Settings.during_time.project_1},
      {name: "Android's Project 2", image: File.open(File.join(Rails.root,
        "app/assets/images/android.png")),
        description: "Start Project 2 for Android today.\r\n",
        content: "<p>Get an introduction to redmine, requirement, design database</p>\r\n", during_time: Settings.during_time.project_2},

      {name: "PHP Tutorial Book", image: File.open(File.join(Rails.root,
        "app/assets/images/php.png")),
        description: "PHP is a server scripting language, and a powerful tool for making dynamic and interactive Web pages.\r\n",
        content: "<p>Get an introduction to numbers, Strings, properties, and methods,&nbsp;
          Learn about conversions, arrays, variables, and more methods</p>\r\n", during_time: Settings.during_time.tutorial_book},
      {name: "PHP's Project 1", image: File.open(File.join(Rails.root,
        "app/assets/images/php.png")),
        description: "Start Project 1 for PHP today.\r\n",
        content: "<p>Get an introduction to redmine, requirement, design database</p>\r\n", during_time: Settings.during_time.project_1},
      {name: "PHP's Project 2", image: File.open(File.join(Rails.root,
        "app/assets/images/php.png")),
        description: "Start Project 2 for PHP today.\r\n",
        content: "<p>Get an introduction to redmine, requirement, design database</p>\r\n", during_time: Settings.during_time.project_2},
      {name: "MySQL", image: File.open(File.join(Rails.root,
        "app/assets/images/subject/mysql.jpg")), description: "Start MySQL today.\r\n", content: "MySQL", during_time: Settings.during_time.mysql},
      {name: "JavaScript", image: File.open(File.join(Rails.root,
        "app/assets/images/subject/javascript.jpg")), description: "JavaScript is the programming language of HTML and the Web.
        Programming makes computers do what you want them to do. JavaScript is easy to learn. This tutorial will teach you JavaScript from basic to advanced.",
        during_time: Settings.during_time.javascript}

    ])

    puts "Create Task Master"
    TaskMaster.create!([
      {name: "From zero to deploy",
        description: "Get an introduction to numbers, Strings, properties, and methods",
        subject_id: 1},
      {name: "A toy app",
        description: "Get an introduction to numbers, Strings, properties, and methods",
        subject_id: 1},
      {name: "Mostly static pages",
        description: "Get an introduction to numbers, Strings, properties, and methods",
        subject_id: 1},
      {name: "Rails-flavored Ruby",
        description: "Get an introduction to numbers, Strings, properties, and methods",
        subject_id: 1},
      {name: "Filling in the layout",
        description: "Get an introduction to numbers, Strings, properties, and methods",
        subject_id: 1},
      {name: "Modeling users",
        description: "Get an introduction to numbers, Strings, properties, and methods",
        subject_id: 1},
      {name: "Sign up",
        description: "Get an introduction to numbers, Strings, properties, and methods",
        subject_id: 1},
      {name: "Basic login",
        description: "Get an introduction to numbers, Strings, properties, and methods",
        subject_id: 1},
      {name: "Advanced login",
        description: "Get an introduction to numbers, Strings, properties, and methods",
        subject_id: 1},
      {name: "Updating, showing, and deleting users",
        description: "Get an introduction to numbers, Strings, properties, and methods",
        subject_id: 1},
      {name: "Account activation",
        description: "Get an introduction to numbers, Strings, properties, and methods",
        subject_id: 1},
      {name: "Password reset",
        description: "Get an introduction to numbers, Strings, properties, and methods",
        subject_id: 1},
      {name: "User microposts",
        description: "Get an introduction to numbers, Strings, properties, and methods",
        subject_id: 1},
      {name: "Following users",
        description: "Get an introduction to numbers, Strings, properties, and methods",
        subject_id: 1},

      {name: "Requirement understanding",
        description: "Get an introduction to project understanding", subject_id: 2},
      {name: "Design Database", description: "Start design database", subject_id: 2},

      {name: "Requirement understanding",
        description: "Get an introduction to project understanding", subject_id: 3},
      {name: "Design Database", description: "Start design database", subject_id: 3},

      {name: "Getting Started",
        description: "Get an introduction to project git", subject_id: 4},
      {name: "Git Basics",
        description: "Get an introduction to project git", subject_id: 4},
      {name: "Git Branching",
        description: "Get an introduction to project git", subject_id: 4},
      {name: "Git on the Server",
        description: "Get an introduction to project git", subject_id: 4},
      {name: "Distributed Git",
        description: "Get an introduction to project git", subject_id: 4},
      {name: "GitHub",
        description: "Get an introduction to project git", subject_id: 4},
      {name: "Git Tools",
        description: "Get an introduction to project git", subject_id: 4},
      {name: "Customizing Git",
        description: "Get an introduction to project git", subject_id: 4},
      {name: "Git and Other Systems",
        description: "Get an introduction to project git", subject_id: 4},
      {name: "Git Internals",
        description: "Get an introduction to project git", subject_id: 4},

      {name: "Installing environment",
        description: "Start your research with Android", subject_id: 5},
      {name: "Learn about Android architecture",
        description: "Start your research with Android", subject_id: 5},
      {name: "Learn about basic components of an Android application",
        description: "Start your research with Android", subject_id: 5},
      {name: "Learn about resources in Android",
        description: "Start your research with Android", subject_id: 5},
      {name: "Activity",
        description: "Start your research with Android", subject_id: 5},
      {name: "UI layout",
        description: "Start your research with Android", subject_id: 5},
      {name: "UI Controls",
        description: "Start your research with Android", subject_id: 5},
      {name: "Event Handling",
        description: "Start your research with Android", subject_id: 5},
      {name: "Animation",
        description: "Start your research with Android", subject_id: 5},
      {name: "Database",
        description: "Start your research with Android", subject_id: 5},
      {name: "Some other components",
        description: "Start your research with Android", subject_id: 5},
      {name: "Some other issues",
        description: "Start your research with Android", subject_id: 5},
      {name: "Thread",
        description: "Start your research with Android", subject_id: 5},

      {name: "Requirement understanding",
        description: "Get an introduction to project git", subject_id: 6},

      {name: "Requirement understanding",
        description: "Get an introduction to project git", subject_id: 7},

      {name: "Introduction to Laravel",
        description: "Get an introduction to Laravel", subject_id: 8},
      {name: "Installation",
        description: "Get an introduction to Laravel", subject_id: 8},
      {name: "Routing",
        description: "Get an introduction to Laravel", subject_id: 8},
      {name: "Middleware",
        description: "Get an introduction to Laravel", subject_id: 8},
      {name: "Controllers",
        description: "Get an introduction to Laravel", subject_id: 8},
      {name: "Request Lifecycle",
        description: "Get an introduction to Laravel", subject_id: 8},
      {name: "Application Structure",
        description: "Get an introduction to Laravel", subject_id: 8},
      {name: "Authentication",
        description: "Get an introduction to Laravel", subject_id: 8},
      {name: "Encryption",
        description: "Get an introduction to Laravel", subject_id: 8},
      {name: "Filesystem / Cloud Storage",
        description: "Get an introduction to Laravel", subject_id: 8},

      {name: "Requirement understanding",
        description: "Get an introduction to project git", subject_id: 9},

      {name: "Requirement understanding",
        description: "Get an introduction to project git", subject_id: 10}
    ])

    puts "Create Course Subject"
    CourseSubject.create!([
      {course_id: 1, subject_id: 1},
      {course_id: 1, subject_id: 2},
      {course_id: 1, subject_id: 3},
      {course_id: 1, subject_id: 4},

      {course_id: 2, subject_id: 4},
      {course_id: 2, subject_id: 5},
      {course_id: 2, subject_id: 6},
      {course_id: 2, subject_id: 7},

      {course_id: 3, subject_id: 4},
      {course_id: 3, subject_id: 8},
      {course_id: 3, subject_id: 9},
      {course_id: 3, subject_id: 10}
    ])

    puts "Creating Permissions"

    trainer_permissions = {
      Course: ["read"],
      CourseSubject: ["read"],
      Evaluation: ["read", "create", "update", "destroy"],
      Note: ["read", "create", "update", "destroy"],
      Notification: ["read", "create"],
      Subject: ["read"],
      User: ["read"],
      UserCourse: ["read"],
      UserSubject: ["update"],
      FeedBack: ["read"]
    }

    trainee_permissions = {
      Course: ["read"],
      Subject: ["read"],
      Task: ["read", "create", "update", "destroy"],
      User: ["read"],
      UserCourse: ["read"],
      UserSubject: ["update"],
      UserTask: ["read", "create", "update", "destroy"],
      FeedBack: ["create"]
    }

    trainer_permissions.each do |permission|
      permission[1].each do |action|
        Permission.create! model_class: permission[0], action: action, role_id: 2
      end
    end

    trainee_permissions.each do |permission|
      permission[1].each do |action|
        Permission.create! model_class: permission[0], action: action, role_id: 3
      end
    end
  end
end
