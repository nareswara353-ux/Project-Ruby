SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: certificates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.certificates (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    course_id bigint NOT NULL,
    code character varying NOT NULL,
    issued_at timestamp(6) without time zone NOT NULL,
    expires_at timestamp(6) without time zone,
    pdf_url character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: certificates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.certificates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: certificates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.certificates_id_seq OWNED BY public.certificates.id;


--
-- Name: course_modules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.course_modules (
    id bigint NOT NULL,
    course_id bigint NOT NULL,
    title character varying NOT NULL,
    description text,
    "position" integer DEFAULT 0 NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    lessons_count integer DEFAULT 0,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: course_modules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.course_modules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: course_modules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.course_modules_id_seq OWNED BY public.course_modules.id;


--
-- Name: courses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.courses (
    id bigint NOT NULL,
    instructor_id bigint NOT NULL,
    title character varying NOT NULL,
    description text,
    price numeric(8,2) DEFAULT 0.0,
    status integer DEFAULT 0 NOT NULL,
    level integer DEFAULT 0 NOT NULL,
    duration integer DEFAULT 0,
    slug character varying NOT NULL,
    cover_image character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: courses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.courses_id_seq OWNED BY public.courses.id;


--
-- Name: discussion_posts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.discussion_posts (
    id bigint NOT NULL,
    discussion_topic_id bigint NOT NULL,
    user_id bigint NOT NULL,
    parent_id bigint,
    content text NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: discussion_posts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.discussion_posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: discussion_posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.discussion_posts_id_seq OWNED BY public.discussion_posts.id;


--
-- Name: discussion_topics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.discussion_topics (
    id bigint NOT NULL,
    course_id bigint NOT NULL,
    user_id bigint NOT NULL,
    title character varying NOT NULL,
    content text NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    pinned boolean DEFAULT false,
    posts_count integer DEFAULT 0,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: discussion_topics_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.discussion_topics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: discussion_topics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.discussion_topics_id_seq OWNED BY public.discussion_topics.id;


--
-- Name: enrollments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.enrollments (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    course_id bigint NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    progress integer DEFAULT 0,
    enrolled_at timestamp(6) without time zone NOT NULL,
    completed_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: enrollments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.enrollments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: enrollments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.enrollments_id_seq OWNED BY public.enrollments.id;


--
-- Name: lesson_completions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lesson_completions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    lesson_id bigint NOT NULL,
    completed_at timestamp(6) without time zone NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: lesson_completions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lesson_completions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lesson_completions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lesson_completions_id_seq OWNED BY public.lesson_completions.id;


--
-- Name: lessons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lessons (
    id bigint NOT NULL,
    course_module_id bigint NOT NULL,
    title character varying NOT NULL,
    content text,
    video_url character varying,
    duration integer DEFAULT 0,
    "position" integer DEFAULT 0 NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    lesson_type integer DEFAULT 0 NOT NULL,
    slug character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: lessons_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lessons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lessons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lessons_id_seq OWNED BY public.lessons.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notifications (
    id bigint NOT NULL,
    recipient_type character varying NOT NULL,
    recipient_id bigint NOT NULL,
    message character varying NOT NULL,
    url character varying,
    read boolean DEFAULT false,
    notifiable_type character varying,
    notifiable_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payments (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    course_id bigint NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    amount numeric(10,2) NOT NULL,
    currency character varying DEFAULT 'usd'::character varying NOT NULL,
    stripe_payment_intent_id character varying,
    stripe_customer_id character varying,
    metadata jsonb DEFAULT '{}'::jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.questions (
    id bigint NOT NULL,
    content text NOT NULL,
    question_type integer DEFAULT 0 NOT NULL,
    option_a character varying,
    option_b character varying,
    option_c character varying,
    option_d character varying,
    correct_answer character varying,
    explanation text,
    difficulty integer DEFAULT 0,
    category character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.questions_id_seq OWNED BY public.questions.id;


--
-- Name: quiz_questions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quiz_questions (
    id bigint NOT NULL,
    quiz_id bigint NOT NULL,
    question_id bigint NOT NULL,
    "position" integer DEFAULT 0 NOT NULL,
    points integer DEFAULT 1 NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: quiz_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quiz_questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: quiz_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.quiz_questions_id_seq OWNED BY public.quiz_questions.id;


--
-- Name: quiz_submissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quiz_submissions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    quiz_id bigint NOT NULL,
    answers jsonb DEFAULT '{}'::jsonb,
    score integer,
    status integer DEFAULT 0 NOT NULL,
    started_at timestamp(6) without time zone,
    submitted_at timestamp(6) without time zone,
    time_taken integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: quiz_submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quiz_submissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: quiz_submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.quiz_submissions_id_seq OWNED BY public.quiz_submissions.id;


--
-- Name: quizzes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quizzes (
    id bigint NOT NULL,
    course_id bigint NOT NULL,
    lesson_id bigint,
    title character varying NOT NULL,
    description text,
    time_limit integer DEFAULT 0,
    passing_score integer DEFAULT 70,
    status integer DEFAULT 0 NOT NULL,
    questions_count integer DEFAULT 0,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: quizzes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quizzes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: quizzes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.quizzes_id_seq OWNED BY public.quizzes.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    remember_created_at timestamp(6) without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp(6) without time zone,
    last_sign_in_at timestamp(6) without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    confirmation_token character varying,
    confirmed_at timestamp(6) without time zone,
    confirmation_sent_at timestamp(6) without time zone,
    unconfirmed_email character varying,
    failed_attempts integer DEFAULT 0 NOT NULL,
    unlock_token character varying,
    locked_at timestamp(6) without time zone,
    name character varying NOT NULL,
    role integer DEFAULT 2 NOT NULL,
    bio text,
    avatar character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: certificates id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.certificates ALTER COLUMN id SET DEFAULT nextval('public.certificates_id_seq'::regclass);


--
-- Name: course_modules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_modules ALTER COLUMN id SET DEFAULT nextval('public.course_modules_id_seq'::regclass);


--
-- Name: courses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.courses ALTER COLUMN id SET DEFAULT nextval('public.courses_id_seq'::regclass);


--
-- Name: discussion_posts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussion_posts ALTER COLUMN id SET DEFAULT nextval('public.discussion_posts_id_seq'::regclass);


--
-- Name: discussion_topics id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussion_topics ALTER COLUMN id SET DEFAULT nextval('public.discussion_topics_id_seq'::regclass);


--
-- Name: enrollments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrollments ALTER COLUMN id SET DEFAULT nextval('public.enrollments_id_seq'::regclass);


--
-- Name: lesson_completions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lesson_completions ALTER COLUMN id SET DEFAULT nextval('public.lesson_completions_id_seq'::regclass);


--
-- Name: lessons id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lessons ALTER COLUMN id SET DEFAULT nextval('public.lessons_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- Name: questions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.questions ALTER COLUMN id SET DEFAULT nextval('public.questions_id_seq'::regclass);


--
-- Name: quiz_questions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_questions ALTER COLUMN id SET DEFAULT nextval('public.quiz_questions_id_seq'::regclass);


--
-- Name: quiz_submissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_submissions ALTER COLUMN id SET DEFAULT nextval('public.quiz_submissions_id_seq'::regclass);


--
-- Name: quizzes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quizzes ALTER COLUMN id SET DEFAULT nextval('public.quizzes_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: certificates certificates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.certificates
    ADD CONSTRAINT certificates_pkey PRIMARY KEY (id);


--
-- Name: course_modules course_modules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_modules
    ADD CONSTRAINT course_modules_pkey PRIMARY KEY (id);


--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- Name: discussion_posts discussion_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussion_posts
    ADD CONSTRAINT discussion_posts_pkey PRIMARY KEY (id);


--
-- Name: discussion_topics discussion_topics_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussion_topics
    ADD CONSTRAINT discussion_topics_pkey PRIMARY KEY (id);


--
-- Name: enrollments enrollments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_pkey PRIMARY KEY (id);


--
-- Name: lesson_completions lesson_completions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lesson_completions
    ADD CONSTRAINT lesson_completions_pkey PRIMARY KEY (id);


--
-- Name: lessons lessons_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: quiz_questions quiz_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_questions
    ADD CONSTRAINT quiz_questions_pkey PRIMARY KEY (id);


--
-- Name: quiz_submissions quiz_submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_submissions
    ADD CONSTRAINT quiz_submissions_pkey PRIMARY KEY (id);


--
-- Name: quizzes quizzes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quizzes
    ADD CONSTRAINT quizzes_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_on_recipient_type_recipient_id_read_8e7ebd1b55; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_on_recipient_type_recipient_id_read_8e7ebd1b55 ON public.notifications USING btree (recipient_type, recipient_id, read);


--
-- Name: index_certificates_on_code; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_certificates_on_code ON public.certificates USING btree (code);


--
-- Name: index_certificates_on_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_certificates_on_course_id ON public.certificates USING btree (course_id);


--
-- Name: index_certificates_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_certificates_on_user_id ON public.certificates USING btree (user_id);


--
-- Name: index_certificates_on_user_id_and_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_certificates_on_user_id_and_course_id ON public.certificates USING btree (user_id, course_id);


--
-- Name: index_course_modules_on_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_course_modules_on_course_id ON public.course_modules USING btree (course_id);


--
-- Name: index_course_modules_on_course_id_and_position; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_course_modules_on_course_id_and_position ON public.course_modules USING btree (course_id, "position");


--
-- Name: index_course_modules_on_course_id_and_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_course_modules_on_course_id_and_status ON public.course_modules USING btree (course_id, status);


--
-- Name: index_courses_on_instructor_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_courses_on_instructor_id ON public.courses USING btree (instructor_id);


--
-- Name: index_courses_on_instructor_id_and_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_courses_on_instructor_id_and_status ON public.courses USING btree (instructor_id, status);


--
-- Name: index_courses_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_courses_on_slug ON public.courses USING btree (slug);


--
-- Name: index_discussion_posts_on_discussion_topic_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_discussion_posts_on_discussion_topic_id ON public.discussion_posts USING btree (discussion_topic_id);


--
-- Name: index_discussion_posts_on_discussion_topic_id_and_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_discussion_posts_on_discussion_topic_id_and_created_at ON public.discussion_posts USING btree (discussion_topic_id, created_at);


--
-- Name: index_discussion_posts_on_parent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_discussion_posts_on_parent_id ON public.discussion_posts USING btree (parent_id);


--
-- Name: index_discussion_posts_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_discussion_posts_on_user_id ON public.discussion_posts USING btree (user_id);


--
-- Name: index_discussion_topics_on_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_discussion_topics_on_course_id ON public.discussion_topics USING btree (course_id);


--
-- Name: index_discussion_topics_on_course_id_and_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_discussion_topics_on_course_id_and_status ON public.discussion_topics USING btree (course_id, status);


--
-- Name: index_discussion_topics_on_pinned; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_discussion_topics_on_pinned ON public.discussion_topics USING btree (pinned);


--
-- Name: index_discussion_topics_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_discussion_topics_on_user_id ON public.discussion_topics USING btree (user_id);


--
-- Name: index_enrollments_on_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_enrollments_on_course_id ON public.enrollments USING btree (course_id);


--
-- Name: index_enrollments_on_course_id_and_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_enrollments_on_course_id_and_status ON public.enrollments USING btree (course_id, status);


--
-- Name: index_enrollments_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_enrollments_on_user_id ON public.enrollments USING btree (user_id);


--
-- Name: index_enrollments_on_user_id_and_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_enrollments_on_user_id_and_course_id ON public.enrollments USING btree (user_id, course_id);


--
-- Name: index_enrollments_on_user_id_and_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_enrollments_on_user_id_and_status ON public.enrollments USING btree (user_id, status);


--
-- Name: index_lesson_completions_on_lesson_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_lesson_completions_on_lesson_id ON public.lesson_completions USING btree (lesson_id);


--
-- Name: index_lesson_completions_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_lesson_completions_on_user_id ON public.lesson_completions USING btree (user_id);


--
-- Name: index_lesson_completions_on_user_id_and_completed_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_lesson_completions_on_user_id_and_completed_at ON public.lesson_completions USING btree (user_id, completed_at);


--
-- Name: index_lesson_completions_on_user_id_and_lesson_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_lesson_completions_on_user_id_and_lesson_id ON public.lesson_completions USING btree (user_id, lesson_id);


--
-- Name: index_lessons_on_course_module_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_lessons_on_course_module_id ON public.lessons USING btree (course_module_id);


--
-- Name: index_lessons_on_course_module_id_and_position; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_lessons_on_course_module_id_and_position ON public.lessons USING btree (course_module_id, "position");


--
-- Name: index_lessons_on_course_module_id_and_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_lessons_on_course_module_id_and_status ON public.lessons USING btree (course_module_id, status);


--
-- Name: index_lessons_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_lessons_on_slug ON public.lessons USING btree (slug);


--
-- Name: index_notifications_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notifications_on_created_at ON public.notifications USING btree (created_at);


--
-- Name: index_notifications_on_notifiable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notifications_on_notifiable ON public.notifications USING btree (notifiable_type, notifiable_id);


--
-- Name: index_notifications_on_recipient; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notifications_on_recipient ON public.notifications USING btree (recipient_type, recipient_id);


--
-- Name: index_payments_on_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_payments_on_course_id ON public.payments USING btree (course_id);


--
-- Name: index_payments_on_course_id_and_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_payments_on_course_id_and_status ON public.payments USING btree (course_id, status);


--
-- Name: index_payments_on_stripe_payment_intent_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_payments_on_stripe_payment_intent_id ON public.payments USING btree (stripe_payment_intent_id);


--
-- Name: index_payments_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_payments_on_user_id ON public.payments USING btree (user_id);


--
-- Name: index_payments_on_user_id_and_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_payments_on_user_id_and_status ON public.payments USING btree (user_id, status);


--
-- Name: index_questions_on_category; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_questions_on_category ON public.questions USING btree (category);


--
-- Name: index_questions_on_difficulty; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_questions_on_difficulty ON public.questions USING btree (difficulty);


--
-- Name: index_questions_on_question_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_questions_on_question_type ON public.questions USING btree (question_type);


--
-- Name: index_quiz_questions_on_question_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_quiz_questions_on_question_id ON public.quiz_questions USING btree (question_id);


--
-- Name: index_quiz_questions_on_quiz_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_quiz_questions_on_quiz_id ON public.quiz_questions USING btree (quiz_id);


--
-- Name: index_quiz_questions_on_quiz_id_and_position; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_quiz_questions_on_quiz_id_and_position ON public.quiz_questions USING btree (quiz_id, "position");


--
-- Name: index_quiz_questions_on_quiz_id_and_question_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_quiz_questions_on_quiz_id_and_question_id ON public.quiz_questions USING btree (quiz_id, question_id);


--
-- Name: index_quiz_submissions_on_quiz_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_quiz_submissions_on_quiz_id ON public.quiz_submissions USING btree (quiz_id);


--
-- Name: index_quiz_submissions_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_quiz_submissions_on_status ON public.quiz_submissions USING btree (status);


--
-- Name: index_quiz_submissions_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_quiz_submissions_on_user_id ON public.quiz_submissions USING btree (user_id);


--
-- Name: index_quiz_submissions_on_user_id_and_quiz_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_quiz_submissions_on_user_id_and_quiz_id ON public.quiz_submissions USING btree (user_id, quiz_id) WHERE (status = 0);


--
-- Name: index_quizzes_on_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_quizzes_on_course_id ON public.quizzes USING btree (course_id);


--
-- Name: index_quizzes_on_course_id_and_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_quizzes_on_course_id_and_status ON public.quizzes USING btree (course_id, status);


--
-- Name: index_quizzes_on_lesson_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_quizzes_on_lesson_id ON public.quizzes USING btree (lesson_id);


--
-- Name: index_quizzes_on_lesson_id_and_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_quizzes_on_lesson_id_and_status ON public.quizzes USING btree (lesson_id, status);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON public.users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_users_on_unlock_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_unlock_token ON public.users USING btree (unlock_token);


--
-- Name: discussion_posts fk_rails_02bae7bd6a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussion_posts
    ADD CONSTRAINT fk_rails_02bae7bd6a FOREIGN KEY (discussion_topic_id) REFERENCES public.discussion_topics(id);


--
-- Name: quiz_submissions fk_rails_04850db4b4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_submissions
    ADD CONSTRAINT fk_rails_04850db4b4 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: payments fk_rails_081dc04a02; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT fk_rails_081dc04a02 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: quizzes fk_rails_0cbde8db7a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quizzes
    ADD CONSTRAINT fk_rails_0cbde8db7a FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- Name: lesson_completions fk_rails_182c3d87f7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lesson_completions
    ADD CONSTRAINT fk_rails_182c3d87f7 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: courses fk_rails_2ab3132eb0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT fk_rails_2ab3132eb0 FOREIGN KEY (instructor_id) REFERENCES public.users(id);


--
-- Name: enrollments fk_rails_2e119501f4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT fk_rails_2e119501f4 FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- Name: quiz_questions fk_rails_389bec88e4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_questions
    ADD CONSTRAINT fk_rails_389bec88e4 FOREIGN KEY (question_id) REFERENCES public.questions(id);


--
-- Name: quiz_submissions fk_rails_473863d022; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_submissions
    ADD CONSTRAINT fk_rails_473863d022 FOREIGN KEY (quiz_id) REFERENCES public.quizzes(id);


--
-- Name: certificates fk_rails_4affdaec3e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.certificates
    ADD CONSTRAINT fk_rails_4affdaec3e FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- Name: quizzes fk_rails_5a8196d7d9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quizzes
    ADD CONSTRAINT fk_rails_5a8196d7d9 FOREIGN KEY (lesson_id) REFERENCES public.lessons(id);


--
-- Name: certificates fk_rails_61bfa47ae6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.certificates
    ADD CONSTRAINT fk_rails_61bfa47ae6 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: payments fk_rails_69cb6780b8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT fk_rails_69cb6780b8 FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- Name: course_modules fk_rails_74391d7a5f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_modules
    ADD CONSTRAINT fk_rails_74391d7a5f FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- Name: discussion_posts fk_rails_76072cc051; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussion_posts
    ADD CONSTRAINT fk_rails_76072cc051 FOREIGN KEY (parent_id) REFERENCES public.discussion_posts(id);


--
-- Name: discussion_topics fk_rails_99a031cbb1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussion_topics
    ADD CONSTRAINT fk_rails_99a031cbb1 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: lesson_completions fk_rails_a283bcc300; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lesson_completions
    ADD CONSTRAINT fk_rails_a283bcc300 FOREIGN KEY (lesson_id) REFERENCES public.lessons(id);


--
-- Name: discussion_posts fk_rails_a8b6de064b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussion_posts
    ADD CONSTRAINT fk_rails_a8b6de064b FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: discussion_topics fk_rails_b7823d07ab; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discussion_topics
    ADD CONSTRAINT fk_rails_b7823d07ab FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- Name: quiz_questions fk_rails_c723d3feef; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_questions
    ADD CONSTRAINT fk_rails_c723d3feef FOREIGN KEY (quiz_id) REFERENCES public.quizzes(id);


--
-- Name: enrollments fk_rails_e860e0e46b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT fk_rails_e860e0e46b FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: lessons fk_rails_e88edeba98; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT fk_rails_e88edeba98 FOREIGN KEY (course_module_id) REFERENCES public.course_modules(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20260907200241'),
('20260907200211'),
('20260907200138'),
('20260907200115'),
('20260907200044'),
('20260907200027'),
('20260907195951'),
('20260906093504'),
('20260906093359'),
('20260906093329'),
('20260906093252'),
('20260906093220'),
('20260906093150'),
('20260906093116'),
('20260906093037');

