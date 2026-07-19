--
-- PostgreSQL database dump
--

\restrict 1zG4MIpSfYK2CoquO6xqtgbhDubA5pLsMcInuILFtUnn8amk6JkpGc0GcSpwoEG

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

-- Started on 2026-07-19 22:16:40

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

--
-- TOC entry 2 (class 3079 OID 25259)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- TOC entry 5566 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 283 (class 1259 OID 25844)
-- Name: adminactivitylogs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.adminactivitylogs (
    activityid bigint NOT NULL,
    userid uuid,
    action character varying(120) NOT NULL,
    entityname character varying(120),
    entityid character varying(80),
    note text,
    ipaddress character varying(80),
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.adminactivitylogs OWNER TO postgres;

--
-- TOC entry 282 (class 1259 OID 25843)
-- Name: adminactivitylogs_activityid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.adminactivitylogs_activityid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.adminactivitylogs_activityid_seq OWNER TO postgres;

--
-- TOC entry 5567 (class 0 OID 0)
-- Dependencies: 282
-- Name: adminactivitylogs_activityid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.adminactivitylogs_activityid_seq OWNED BY public.adminactivitylogs.activityid;


--
-- TOC entry 218 (class 1259 OID 25296)
-- Name: auditlogs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auditlogs (
    logid integer NOT NULL,
    userid uuid,
    action character varying(200),
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.auditlogs OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 25300)
-- Name: auditlogs_logid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auditlogs_logid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.auditlogs_logid_seq OWNER TO postgres;

--
-- TOC entry 5568 (class 0 OID 0)
-- Dependencies: 219
-- Name: auditlogs_logid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auditlogs_logid_seq OWNED BY public.auditlogs.logid;


--
-- TOC entry 220 (class 1259 OID 25301)
-- Name: brands; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.brands (
    brandid integer NOT NULL,
    brandname character varying(100) NOT NULL,
    country character varying(100),
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.brands OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 25305)
-- Name: brands_brandid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.brands_brandid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.brands_brandid_seq OWNER TO postgres;

--
-- TOC entry 5569 (class 0 OID 0)
-- Dependencies: 221
-- Name: brands_brandid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.brands_brandid_seq OWNED BY public.brands.brandid;


--
-- TOC entry 222 (class 1259 OID 25306)
-- Name: cartitems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cartitems (
    cartitemid integer NOT NULL,
    cartid integer,
    productid integer,
    quantity integer NOT NULL
);


ALTER TABLE public.cartitems OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 25309)
-- Name: cartitems_cartitemid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cartitems_cartitemid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cartitems_cartitemid_seq OWNER TO postgres;

--
-- TOC entry 5570 (class 0 OID 0)
-- Dependencies: 223
-- Name: cartitems_cartitemid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cartitems_cartitemid_seq OWNED BY public.cartitems.cartitemid;


--
-- TOC entry 224 (class 1259 OID 25310)
-- Name: carts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carts (
    cartid integer NOT NULL,
    userid uuid,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.carts OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 25314)
-- Name: carts_cartid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.carts_cartid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.carts_cartid_seq OWNER TO postgres;

--
-- TOC entry 5571 (class 0 OID 0)
-- Dependencies: 225
-- Name: carts_cartid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.carts_cartid_seq OWNED BY public.carts.cartid;


--
-- TOC entry 226 (class 1259 OID 25315)
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    categoryid integer NOT NULL,
    categoryname character varying(100) NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 25318)
-- Name: categories_categoryid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_categoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_categoryid_seq OWNER TO postgres;

--
-- TOC entry 5572 (class 0 OID 0)
-- Dependencies: 227
-- Name: categories_categoryid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_categoryid_seq OWNED BY public.categories.categoryid;


--
-- TOC entry 228 (class 1259 OID 25319)
-- Name: chatconversations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chatconversations (
    conversationid integer NOT NULL,
    userid uuid NOT NULL,
    subject character varying(200) DEFAULT 'Hỗ trợ khách hàng'::character varying NOT NULL,
    status character varying(30) DEFAULT 'Open'::character varying NOT NULL,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updatedat timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    closedat timestamp without time zone
);


ALTER TABLE public.chatconversations OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 25326)
-- Name: chatconversations_conversationid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.chatconversations_conversationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.chatconversations_conversationid_seq OWNER TO postgres;

--
-- TOC entry 5573 (class 0 OID 0)
-- Dependencies: 229
-- Name: chatconversations_conversationid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.chatconversations_conversationid_seq OWNED BY public.chatconversations.conversationid;


--
-- TOC entry 230 (class 1259 OID 25327)
-- Name: chatmessages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.chatmessages (
    messageid integer NOT NULL,
    conversationid integer NOT NULL,
    senderid uuid NOT NULL,
    message text NOT NULL,
    isread boolean DEFAULT false NOT NULL,
    issystem boolean DEFAULT false NOT NULL,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.chatmessages OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 25335)
-- Name: chatmessages_messageid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.chatmessages_messageid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.chatmessages_messageid_seq OWNER TO postgres;

--
-- TOC entry 5574 (class 0 OID 0)
-- Dependencies: 231
-- Name: chatmessages_messageid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.chatmessages_messageid_seq OWNED BY public.chatmessages.messageid;


--
-- TOC entry 273 (class 1259 OID 25767)
-- Name: contentcategories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contentcategories (
    categoryid integer NOT NULL,
    categoryname character varying(150) NOT NULL,
    slug character varying(180),
    description text,
    isactive boolean DEFAULT true,
    displayorder integer DEFAULT 0,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.contentcategories OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 25766)
-- Name: contentcategories_categoryid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contentcategories_categoryid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contentcategories_categoryid_seq OWNER TO postgres;

--
-- TOC entry 5575 (class 0 OID 0)
-- Dependencies: 272
-- Name: contentcategories_categoryid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contentcategories_categoryid_seq OWNED BY public.contentcategories.categoryid;


--
-- TOC entry 281 (class 1259 OID 25826)
-- Name: customerbehaviors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customerbehaviors (
    behaviorid bigint NOT NULL,
    userid uuid,
    sessionid character varying(100),
    eventtype character varying(80) NOT NULL,
    targettype character varying(80),
    targetid integer,
    keyword character varying(300),
    sourceurl text,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.customerbehaviors OWNER TO postgres;

--
-- TOC entry 280 (class 1259 OID 25825)
-- Name: customerbehaviors_behaviorid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customerbehaviors_behaviorid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customerbehaviors_behaviorid_seq OWNER TO postgres;

--
-- TOC entry 5576 (class 0 OID 0)
-- Dependencies: 280
-- Name: customerbehaviors_behaviorid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customerbehaviors_behaviorid_seq OWNED BY public.customerbehaviors.behaviorid;


--
-- TOC entry 277 (class 1259 OID 25801)
-- Name: faqitems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.faqitems (
    faqid integer NOT NULL,
    question character varying(250) NOT NULL,
    answer text NOT NULL,
    keywords character varying(300),
    groupname character varying(80),
    displayorder integer DEFAULT 0,
    isactive boolean DEFAULT true,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.faqitems OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 25800)
-- Name: faqitems_faqid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.faqitems_faqid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.faqitems_faqid_seq OWNER TO postgres;

--
-- TOC entry 5577 (class 0 OID 0)
-- Dependencies: 276
-- Name: faqitems_faqid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.faqitems_faqid_seq OWNED BY public.faqitems.faqid;


--
-- TOC entry 285 (class 1259 OID 25862)
-- Name: homepagebanners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.homepagebanners (
    bannerid integer NOT NULL,
    title character varying(180) NOT NULL,
    subtitle character varying(300),
    imageurl text,
    targeturl text,
    badgetext character varying(80),
    displayorder integer DEFAULT 0,
    isactive boolean DEFAULT true,
    startat timestamp without time zone,
    endat timestamp without time zone,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.homepagebanners OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 25861)
-- Name: homepagebanners_bannerid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.homepagebanners_bannerid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.homepagebanners_bannerid_seq OWNER TO postgres;

--
-- TOC entry 5578 (class 0 OID 0)
-- Dependencies: 284
-- Name: homepagebanners_bannerid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.homepagebanners_bannerid_seq OWNED BY public.homepagebanners.bannerid;


--
-- TOC entry 291 (class 1259 OID 25925)
-- Name: installmentplans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.installmentplans (
    planid integer NOT NULL,
    planname character varying(120) NOT NULL,
    termmonths integer NOT NULL,
    interestpercent numeric(6,2) DEFAULT 0,
    minprepaidpercent numeric(6,2) DEFAULT 0,
    isactive boolean DEFAULT true,
    displayorder integer DEFAULT 0,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT installmentplans_termmonths_check CHECK ((termmonths > 0))
);


ALTER TABLE public.installmentplans OWNER TO postgres;

--
-- TOC entry 290 (class 1259 OID 25924)
-- Name: installmentplans_planid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.installmentplans_planid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.installmentplans_planid_seq OWNER TO postgres;

--
-- TOC entry 5579 (class 0 OID 0)
-- Dependencies: 290
-- Name: installmentplans_planid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.installmentplans_planid_seq OWNED BY public.installmentplans.planid;


--
-- TOC entry 293 (class 1259 OID 25939)
-- Name: installmentrequests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.installmentrequests (
    requestid integer NOT NULL,
    userid uuid NOT NULL,
    productid integer,
    planid integer,
    productprice numeric(18,2) DEFAULT 0 NOT NULL,
    prepaidamount numeric(18,2) DEFAULT 0 NOT NULL,
    termmonths integer DEFAULT 0 NOT NULL,
    interestpercent numeric(6,2) DEFAULT 0 NOT NULL,
    monthlypayment numeric(18,2) DEFAULT 0 NOT NULL,
    totalpayment numeric(18,2) DEFAULT 0 NOT NULL,
    customerphone character varying(20) NOT NULL,
    customerjob character varying(150),
    customerincome numeric(18,2),
    idcardlast4 character varying(30),
    status character varying(30) DEFAULT 'Pending'::character varying,
    adminnote text,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updatedat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.installmentrequests OWNER TO postgres;

--
-- TOC entry 292 (class 1259 OID 25938)
-- Name: installmentrequests_requestid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.installmentrequests_requestid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.installmentrequests_requestid_seq OWNER TO postgres;

--
-- TOC entry 5580 (class 0 OID 0)
-- Dependencies: 292
-- Name: installmentrequests_requestid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.installmentrequests_requestid_seq OWNED BY public.installmentrequests.requestid;


--
-- TOC entry 299 (class 1259 OID 26020)
-- Name: loyaltypointtransactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.loyaltypointtransactions (
    transactionid integer NOT NULL,
    userid uuid NOT NULL,
    orderid integer,
    points integer NOT NULL,
    transactiontype character varying(30) NOT NULL,
    note text,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.loyaltypointtransactions OWNER TO postgres;

--
-- TOC entry 298 (class 1259 OID 26019)
-- Name: loyaltypointtransactions_transactionid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.loyaltypointtransactions_transactionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.loyaltypointtransactions_transactionid_seq OWNER TO postgres;

--
-- TOC entry 5581 (class 0 OID 0)
-- Dependencies: 298
-- Name: loyaltypointtransactions_transactionid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.loyaltypointtransactions_transactionid_seq OWNED BY public.loyaltypointtransactions.transactionid;


--
-- TOC entry 279 (class 1259 OID 25814)
-- Name: marketingcampaigns; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.marketingcampaigns (
    campaignid integer NOT NULL,
    campaignname character varying(180) NOT NULL,
    channel character varying(60),
    targetsegment character varying(100),
    status character varying(40) DEFAULT 'Draft'::character varying,
    budget numeric(18,2),
    message text,
    landingurl text,
    startat timestamp without time zone,
    endat timestamp without time zone,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.marketingcampaigns OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 25813)
-- Name: marketingcampaigns_campaignid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.marketingcampaigns_campaignid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.marketingcampaigns_campaignid_seq OWNER TO postgres;

--
-- TOC entry 5582 (class 0 OID 0)
-- Dependencies: 278
-- Name: marketingcampaigns_campaignid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.marketingcampaigns_campaignid_seq OWNED BY public.marketingcampaigns.campaignid;


--
-- TOC entry 275 (class 1259 OID 25780)
-- Name: newsarticles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.newsarticles (
    articleid integer NOT NULL,
    categoryid integer,
    title character varying(220) NOT NULL,
    slug character varying(260),
    summary text,
    content text NOT NULL,
    imageurl text,
    authorname character varying(120),
    tags character varying(300),
    ispublished boolean DEFAULT false,
    viewcount integer DEFAULT 0,
    publishedat timestamp without time zone,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updatedat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.newsarticles OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 25779)
-- Name: newsarticles_articleid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.newsarticles_articleid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.newsarticles_articleid_seq OWNER TO postgres;

--
-- TOC entry 5583 (class 0 OID 0)
-- Dependencies: 274
-- Name: newsarticles_articleid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.newsarticles_articleid_seq OWNED BY public.newsarticles.articleid;


--
-- TOC entry 302 (class 1259 OID 26050)
-- Name: newslettersubscribers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.newslettersubscribers (
    subscriberid integer NOT NULL,
    email character varying(150) NOT NULL,
    fullname character varying(150),
    isactive boolean DEFAULT true,
    subscribedat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.newslettersubscribers OWNER TO postgres;

--
-- TOC entry 301 (class 1259 OID 26049)
-- Name: newslettersubscribers_subscriberid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.newslettersubscribers_subscriberid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.newslettersubscribers_subscriberid_seq OWNER TO postgres;

--
-- TOC entry 5584 (class 0 OID 0)
-- Dependencies: 301
-- Name: newslettersubscribers_subscriberid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.newslettersubscribers_subscriberid_seq OWNED BY public.newslettersubscribers.subscriberid;


--
-- TOC entry 267 (class 1259 OID 25710)
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    notificationid bigint NOT NULL,
    userid uuid,
    title character varying(160) NOT NULL,
    message character varying(1000),
    type character varying(40) DEFAULT 'System'::character varying,
    targeturl character varying(500),
    isread boolean DEFAULT false,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 25709)
-- Name: notifications_notificationid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_notificationid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notifications_notificationid_seq OWNER TO postgres;

--
-- TOC entry 5585 (class 0 OID 0)
-- Dependencies: 266
-- Name: notifications_notificationid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_notificationid_seq OWNED BY public.notifications.notificationid;


--
-- TOC entry 232 (class 1259 OID 25336)
-- Name: orderdetails; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orderdetails (
    orderdetailid integer NOT NULL,
    orderid integer,
    productid integer,
    quantity integer NOT NULL,
    price numeric(18,2) NOT NULL
);


ALTER TABLE public.orderdetails OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 25339)
-- Name: orderdetails_orderdetailid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orderdetails_orderdetailid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orderdetails_orderdetailid_seq OWNER TO postgres;

--
-- TOC entry 5586 (class 0 OID 0)
-- Dependencies: 233
-- Name: orderdetails_orderdetailid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orderdetails_orderdetailid_seq OWNED BY public.orderdetails.orderdetailid;


--
-- TOC entry 234 (class 1259 OID 25340)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    orderid integer NOT NULL,
    userid uuid,
    ordercode character varying(30),
    totalamount numeric(18,2),
    status character varying(50),
    paymentmethod character varying(50),
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    voucherid integer,
    receivername character varying(150),
    receiverphone character varying(20),
    shippingaddress text,
    note text,
    subtotalamount numeric(18,2),
    discountamount numeric(18,2) DEFAULT 0
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 25346)
-- Name: orders_orderid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_orderid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_orderid_seq OWNER TO postgres;

--
-- TOC entry 5587 (class 0 OID 0)
-- Dependencies: 235
-- Name: orders_orderid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_orderid_seq OWNED BY public.orders.orderid;


--
-- TOC entry 306 (class 1259 OID 26073)
-- Name: ordershipments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ordershipments (
    shipmentid integer NOT NULL,
    orderid integer NOT NULL,
    providerid integer,
    trackingnumber character varying(80),
    shippingfee numeric(18,2) DEFAULT 0,
    shiptoaddress text,
    status character varying(40) DEFAULT 'Preparing'::character varying,
    estimateddeliverydate timestamp without time zone,
    shippedat timestamp without time zone,
    deliveredat timestamp without time zone,
    adminnote text,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updatedat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.ordershipments OWNER TO postgres;

--
-- TOC entry 305 (class 1259 OID 26072)
-- Name: ordershipments_shipmentid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ordershipments_shipmentid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ordershipments_shipmentid_seq OWNER TO postgres;

--
-- TOC entry 5588 (class 0 OID 0)
-- Dependencies: 305
-- Name: ordershipments_shipmentid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ordershipments_shipmentid_seq OWNED BY public.ordershipments.shipmentid;


--
-- TOC entry 236 (class 1259 OID 25347)
-- Name: orderstatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orderstatus (
    statusid integer NOT NULL,
    statusname character varying(50)
);


ALTER TABLE public.orderstatus OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 25350)
-- Name: orderstatus_statusid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orderstatus_statusid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orderstatus_statusid_seq OWNER TO postgres;

--
-- TOC entry 5589 (class 0 OID 0)
-- Dependencies: 237
-- Name: orderstatus_statusid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orderstatus_statusid_seq OWNED BY public.orderstatus.statusid;


--
-- TOC entry 238 (class 1259 OID 25351)
-- Name: orderstatushistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orderstatushistory (
    historyid integer NOT NULL,
    orderid integer,
    statusid integer,
    changedat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.orderstatushistory OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 25355)
-- Name: orderstatushistory_historyid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orderstatushistory_historyid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orderstatushistory_historyid_seq OWNER TO postgres;

--
-- TOC entry 5590 (class 0 OID 0)
-- Dependencies: 239
-- Name: orderstatushistory_historyid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orderstatushistory_historyid_seq OWNED BY public.orderstatushistory.historyid;


--
-- TOC entry 308 (class 1259 OID 26099)
-- Name: paymenttransactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.paymenttransactions (
    transactionid bigint NOT NULL,
    orderid integer,
    userid uuid,
    transactioncode character varying(60) NOT NULL,
    paymentmethod character varying(60),
    amount numeric(18,2) DEFAULT 0 NOT NULL,
    status character varying(30) DEFAULT 'Pending'::character varying,
    gatewayname character varying(80),
    note text,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.paymenttransactions OWNER TO postgres;

--
-- TOC entry 307 (class 1259 OID 26098)
-- Name: paymenttransactions_transactionid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.paymenttransactions_transactionid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.paymenttransactions_transactionid_seq OWNER TO postgres;

--
-- TOC entry 5591 (class 0 OID 0)
-- Dependencies: 307
-- Name: paymenttransactions_transactionid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.paymenttransactions_transactionid_seq OWNED BY public.paymenttransactions.transactionid;


--
-- TOC entry 314 (class 1259 OID 26165)
-- Name: pickupappointments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pickupappointments (
    appointmentid integer NOT NULL,
    userid uuid NOT NULL,
    orderid integer,
    branchid integer,
    appointmentdate timestamp without time zone NOT NULL,
    timeslot character varying(50) NOT NULL,
    status character varying(30) DEFAULT 'Pending'::character varying,
    note text,
    adminnote text,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updatedat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.pickupappointments OWNER TO postgres;

--
-- TOC entry 313 (class 1259 OID 26164)
-- Name: pickupappointments_appointmentid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pickupappointments_appointmentid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pickupappointments_appointmentid_seq OWNER TO postgres;

--
-- TOC entry 5592 (class 0 OID 0)
-- Dependencies: 313
-- Name: pickupappointments_appointmentid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pickupappointments_appointmentid_seq OWNED BY public.pickupappointments.appointmentid;


--
-- TOC entry 271 (class 1259 OID 25747)
-- Name: productbundleitems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productbundleitems (
    bundleitemid integer NOT NULL,
    bundleid integer NOT NULL,
    productid integer NOT NULL,
    quantity integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.productbundleitems OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 25746)
-- Name: productbundleitems_bundleitemid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.productbundleitems_bundleitemid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.productbundleitems_bundleitemid_seq OWNER TO postgres;

--
-- TOC entry 5593 (class 0 OID 0)
-- Dependencies: 270
-- Name: productbundleitems_bundleitemid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productbundleitems_bundleitemid_seq OWNED BY public.productbundleitems.bundleitemid;


--
-- TOC entry 269 (class 1259 OID 25732)
-- Name: productbundles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productbundles (
    bundleid integer NOT NULL,
    bundlename character varying(200) NOT NULL,
    slug character varying(220),
    description text,
    coverimageurl text,
    originalprice numeric(18,2),
    bundleprice numeric(18,2) DEFAULT 0 NOT NULL,
    badgetext character varying(80),
    isactive boolean DEFAULT true,
    displayorder integer DEFAULT 0,
    startat timestamp without time zone,
    endat timestamp without time zone,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.productbundles OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 25731)
-- Name: productbundles_bundleid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.productbundles_bundleid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.productbundles_bundleid_seq OWNER TO postgres;

--
-- TOC entry 5594 (class 0 OID 0)
-- Dependencies: 268
-- Name: productbundles_bundleid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productbundles_bundleid_seq OWNED BY public.productbundles.bundleid;


--
-- TOC entry 240 (class 1259 OID 25356)
-- Name: productimages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productimages (
    imageid integer NOT NULL,
    productid integer,
    imageurl text NOT NULL,
    ismain boolean DEFAULT false
);


ALTER TABLE public.productimages OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 25362)
-- Name: productimages_imageid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.productimages_imageid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.productimages_imageid_seq OWNER TO postgres;

--
-- TOC entry 5595 (class 0 OID 0)
-- Dependencies: 241
-- Name: productimages_imageid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productimages_imageid_seq OWNED BY public.productimages.imageid;


--
-- TOC entry 297 (class 1259 OID 25999)
-- Name: productpricealerts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productpricealerts (
    alertid integer NOT NULL,
    userid uuid NOT NULL,
    productid integer NOT NULL,
    targetprice numeric(18,2) NOT NULL,
    isactive boolean DEFAULT true,
    isnotified boolean DEFAULT false,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    notifiedat timestamp without time zone
);


ALTER TABLE public.productpricealerts OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 25998)
-- Name: productpricealerts_alertid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.productpricealerts_alertid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.productpricealerts_alertid_seq OWNER TO postgres;

--
-- TOC entry 5596 (class 0 OID 0)
-- Dependencies: 296
-- Name: productpricealerts_alertid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productpricealerts_alertid_seq OWNED BY public.productpricealerts.alertid;


--
-- TOC entry 265 (class 1259 OID 25693)
-- Name: productpromotions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productpromotions (
    promotionid integer NOT NULL,
    productid integer,
    title character varying(150),
    badgetext character varying(60),
    discountpercent integer,
    saleprice numeric(18,2),
    startat timestamp without time zone,
    endat timestamp without time zone,
    isactive boolean DEFAULT true,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT ck_productpromotions_discountpercent CHECK (((discountpercent IS NULL) OR ((discountpercent >= 1) AND (discountpercent <= 99)))),
    CONSTRAINT productpromotions_discountpercent_check CHECK (((discountpercent IS NULL) OR ((discountpercent >= 1) AND (discountpercent <= 99))))
);


ALTER TABLE public.productpromotions OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 25692)
-- Name: productpromotions_promotionid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.productpromotions_promotionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.productpromotions_promotionid_seq OWNER TO postgres;

--
-- TOC entry 5597 (class 0 OID 0)
-- Dependencies: 264
-- Name: productpromotions_promotionid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productpromotions_promotionid_seq OWNED BY public.productpromotions.promotionid;


--
-- TOC entry 259 (class 1259 OID 25619)
-- Name: productquestions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productquestions (
    questionid integer NOT NULL,
    productid integer,
    userid uuid,
    question character varying(1000) NOT NULL,
    answer character varying(1000),
    answeredbyuserid uuid,
    isvisible boolean DEFAULT true,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    answeredat timestamp without time zone
);


ALTER TABLE public.productquestions OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 25618)
-- Name: productquestions_questionid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.productquestions_questionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.productquestions_questionid_seq OWNER TO postgres;

--
-- TOC entry 5598 (class 0 OID 0)
-- Dependencies: 258
-- Name: productquestions_questionid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productquestions_questionid_seq OWNED BY public.productquestions.questionid;


--
-- TOC entry 242 (class 1259 OID 25363)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    productid integer NOT NULL,
    productname character varying(200) NOT NULL,
    price numeric(18,2) NOT NULL,
    quantity integer DEFAULT 0,
    description text,
    imageurl text,
    brandid integer,
    categoryid integer,
    isactive boolean DEFAULT true,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 25371)
-- Name: products_productid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_productid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_productid_seq OWNER TO postgres;

--
-- TOC entry 5599 (class 0 OID 0)
-- Dependencies: 243
-- Name: products_productid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_productid_seq OWNED BY public.products.productid;


--
-- TOC entry 244 (class 1259 OID 25372)
-- Name: productspecifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productspecifications (
    productid integer NOT NULL,
    specid integer NOT NULL,
    specvalue character varying(100)
);


ALTER TABLE public.productspecifications OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 25648)
-- Name: productviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productviews (
    viewid bigint NOT NULL,
    productid integer,
    userid uuid,
    sessionkey character varying(120),
    viewedat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.productviews OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 25647)
-- Name: productviews_viewid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.productviews_viewid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.productviews_viewid_seq OWNER TO postgres;

--
-- TOC entry 5600 (class 0 OID 0)
-- Dependencies: 260
-- Name: productviews_viewid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productviews_viewid_seq OWNED BY public.productviews.viewid;


--
-- TOC entry 310 (class 1259 OID 26124)
-- Name: refundrequests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.refundrequests (
    refundid integer NOT NULL,
    orderid integer NOT NULL,
    userid uuid NOT NULL,
    paymenttransactionid bigint,
    amount numeric(18,2) DEFAULT 0 NOT NULL,
    reason text NOT NULL,
    status character varying(30) DEFAULT 'Pending'::character varying,
    adminnote text,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updatedat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.refundrequests OWNER TO postgres;

--
-- TOC entry 309 (class 1259 OID 26123)
-- Name: refundrequests_refundid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.refundrequests_refundid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.refundrequests_refundid_seq OWNER TO postgres;

--
-- TOC entry 5601 (class 0 OID 0)
-- Dependencies: 309
-- Name: refundrequests_refundid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.refundrequests_refundid_seq OWNED BY public.refundrequests.refundid;


--
-- TOC entry 245 (class 1259 OID 25375)
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    reviewid integer NOT NULL,
    productid integer,
    userid uuid,
    rating integer,
    comment text,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT reviews_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 25382)
-- Name: reviews_reviewid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reviews_reviewid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reviews_reviewid_seq OWNER TO postgres;

--
-- TOC entry 5602 (class 0 OID 0)
-- Dependencies: 246
-- Name: reviews_reviewid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reviews_reviewid_seq OWNED BY public.reviews.reviewid;


--
-- TOC entry 247 (class 1259 OID 25383)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    roleid integer NOT NULL,
    rolename character varying(50) NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 25386)
-- Name: roles_roleid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_roleid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_roleid_seq OWNER TO postgres;

--
-- TOC entry 5603 (class 0 OID 0)
-- Dependencies: 248
-- Name: roles_roleid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_roleid_seq OWNED BY public.roles.roleid;


--
-- TOC entry 304 (class 1259 OID 26062)
-- Name: shippingproviders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shippingproviders (
    providerid integer NOT NULL,
    providername character varying(120) NOT NULL,
    hotline character varying(30),
    trackingurltemplate character varying(500),
    isactive boolean DEFAULT true,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.shippingproviders OWNER TO postgres;

--
-- TOC entry 303 (class 1259 OID 26061)
-- Name: shippingproviders_providerid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shippingproviders_providerid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.shippingproviders_providerid_seq OWNER TO postgres;

--
-- TOC entry 5604 (class 0 OID 0)
-- Dependencies: 303
-- Name: shippingproviders_providerid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shippingproviders_providerid_seq OWNED BY public.shippingproviders.providerid;


--
-- TOC entry 300 (class 1259 OID 26041)
-- Name: siteconfigs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.siteconfigs (
    configkey character varying(100) NOT NULL,
    configvalue text,
    groupname character varying(80),
    description text,
    updatedat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.siteconfigs OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 25387)
-- Name: specifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.specifications (
    specid integer NOT NULL,
    specname character varying(100) NOT NULL
);


ALTER TABLE public.specifications OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 25390)
-- Name: specifications_specid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.specifications_specid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.specifications_specid_seq OWNER TO postgres;

--
-- TOC entry 5605 (class 0 OID 0)
-- Dependencies: 250
-- Name: specifications_specid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.specifications_specid_seq OWNED BY public.specifications.specid;


--
-- TOC entry 263 (class 1259 OID 25669)
-- Name: stockmovements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stockmovements (
    movementid bigint NOT NULL,
    productid integer,
    userid uuid,
    movementtype character varying(40) DEFAULT 'Adjustment'::character varying NOT NULL,
    quantitychange integer NOT NULL,
    quantitybefore integer,
    quantityafter integer,
    referencecode character varying(200),
    note character varying(500),
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.stockmovements OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 25668)
-- Name: stockmovements_movementid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stockmovements_movementid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stockmovements_movementid_seq OWNER TO postgres;

--
-- TOC entry 5606 (class 0 OID 0)
-- Dependencies: 262
-- Name: stockmovements_movementid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stockmovements_movementid_seq OWNED BY public.stockmovements.movementid;


--
-- TOC entry 312 (class 1259 OID 26154)
-- Name: storebranches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.storebranches (
    branchid integer NOT NULL,
    branchname character varying(150) NOT NULL,
    address text NOT NULL,
    phone character varying(30),
    openhours character varying(100),
    mapurl character varying(500),
    isactive boolean DEFAULT true,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.storebranches OWNER TO postgres;

--
-- TOC entry 311 (class 1259 OID 26153)
-- Name: storebranches_branchid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.storebranches_branchid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.storebranches_branchid_seq OWNER TO postgres;

--
-- TOC entry 5607 (class 0 OID 0)
-- Dependencies: 311
-- Name: storebranches_branchid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.storebranches_branchid_seq OWNED BY public.storebranches.branchid;


--
-- TOC entry 287 (class 1259 OID 25874)
-- Name: supporttickets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.supporttickets (
    ticketid integer NOT NULL,
    userid uuid,
    fullname character varying(150) NOT NULL,
    email character varying(150) NOT NULL,
    phone character varying(20),
    subject character varying(200) NOT NULL,
    message text NOT NULL,
    status character varying(30) DEFAULT 'Open'::character varying,
    adminreply text,
    repliedat timestamp without time zone,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updatedat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.supporttickets OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 25873)
-- Name: supporttickets_ticketid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.supporttickets_ticketid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.supporttickets_ticketid_seq OWNER TO postgres;

--
-- TOC entry 5608 (class 0 OID 0)
-- Dependencies: 286
-- Name: supporttickets_ticketid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.supporttickets_ticketid_seq OWNED BY public.supporttickets.ticketid;


--
-- TOC entry 295 (class 1259 OID 25974)
-- Name: tradeinrequests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tradeinrequests (
    requestid integer NOT NULL,
    userid uuid NOT NULL,
    targetproductid integer,
    olddevicebrand character varying(80) NOT NULL,
    olddevicemodel character varying(150) NOT NULL,
    imei character varying(60),
    conditionlevel character varying(40) DEFAULT 'Good'::character varying NOT NULL,
    customerdescription text,
    estimatedvalue numeric(18,2),
    status character varying(30) DEFAULT 'Pending'::character varying,
    adminnote text,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updatedat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.tradeinrequests OWNER TO postgres;

--
-- TOC entry 294 (class 1259 OID 25973)
-- Name: tradeinrequests_requestid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tradeinrequests_requestid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tradeinrequests_requestid_seq OWNER TO postgres;

--
-- TOC entry 5609 (class 0 OID 0)
-- Dependencies: 294
-- Name: tradeinrequests_requestid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tradeinrequests_requestid_seq OWNED BY public.tradeinrequests.requestid;


--
-- TOC entry 251 (class 1259 OID 25391)
-- Name: useraddresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.useraddresses (
    addressid integer NOT NULL,
    userid uuid,
    receivername character varying(150),
    phone character varying(20),
    address text,
    isdefault boolean DEFAULT false
);


ALTER TABLE public.useraddresses OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 25397)
-- Name: useraddresses_addressid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.useraddresses_addressid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.useraddresses_addressid_seq OWNER TO postgres;

--
-- TOC entry 5610 (class 0 OID 0)
-- Dependencies: 252
-- Name: useraddresses_addressid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.useraddresses_addressid_seq OWNED BY public.useraddresses.addressid;


--
-- TOC entry 253 (class 1259 OID 25398)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    userid uuid DEFAULT gen_random_uuid() NOT NULL,
    fullname character varying(150) NOT NULL,
    email character varying(150) NOT NULL,
    passwordhash text NOT NULL,
    phone character varying(20),
    address text,
    roleid integer,
    isactive boolean DEFAULT true,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updatedat timestamp without time zone,
    lastloginat timestamp without time zone,
    lockedreason text,
    avatarurl text
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 25406)
-- Name: vouchers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vouchers (
    voucherid integer NOT NULL,
    code character varying(50),
    discountpercent integer,
    maxdiscount numeric(18,2),
    expiredat timestamp without time zone,
    quantity integer
);


ALTER TABLE public.vouchers OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 25409)
-- Name: vouchers_voucherid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vouchers_voucherid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vouchers_voucherid_seq OWNER TO postgres;

--
-- TOC entry 5611 (class 0 OID 0)
-- Dependencies: 255
-- Name: vouchers_voucherid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vouchers_voucherid_seq OWNED BY public.vouchers.voucherid;


--
-- TOC entry 289 (class 1259 OID 25891)
-- Name: warrantyrequests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.warrantyrequests (
    warrantyrequestid integer NOT NULL,
    userid uuid NOT NULL,
    orderid integer,
    productid integer,
    requesttype character varying(30) DEFAULT 'Warranty'::character varying NOT NULL,
    status character varying(30) DEFAULT 'Pending'::character varying,
    reason text NOT NULL,
    customerimageurl text,
    adminnote text,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updatedat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.warrantyrequests OWNER TO postgres;

--
-- TOC entry 288 (class 1259 OID 25890)
-- Name: warrantyrequests_warrantyrequestid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.warrantyrequests_warrantyrequestid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.warrantyrequests_warrantyrequestid_seq OWNER TO postgres;

--
-- TOC entry 5612 (class 0 OID 0)
-- Dependencies: 288
-- Name: warrantyrequests_warrantyrequestid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.warrantyrequests_warrantyrequestid_seq OWNED BY public.warrantyrequests.warrantyrequestid;


--
-- TOC entry 257 (class 1259 OID 25597)
-- Name: wishlistitems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wishlistitems (
    wishlistitemid integer NOT NULL,
    userid uuid NOT NULL,
    productid integer NOT NULL,
    createdat timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.wishlistitems OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 25596)
-- Name: wishlistitems_wishlistitemid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wishlistitems_wishlistitemid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.wishlistitems_wishlistitemid_seq OWNER TO postgres;

--
-- TOC entry 5613 (class 0 OID 0)
-- Dependencies: 256
-- Name: wishlistitems_wishlistitemid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wishlistitems_wishlistitemid_seq OWNED BY public.wishlistitems.wishlistitemid;


--
-- TOC entry 5002 (class 2604 OID 25847)
-- Name: adminactivitylogs activityid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adminactivitylogs ALTER COLUMN activityid SET DEFAULT nextval('public.adminactivitylogs_activityid_seq'::regclass);


--
-- TOC entry 4920 (class 2604 OID 25410)
-- Name: auditlogs logid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auditlogs ALTER COLUMN logid SET DEFAULT nextval('public.auditlogs_logid_seq'::regclass);


--
-- TOC entry 4922 (class 2604 OID 25411)
-- Name: brands brandid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brands ALTER COLUMN brandid SET DEFAULT nextval('public.brands_brandid_seq'::regclass);


--
-- TOC entry 4924 (class 2604 OID 25412)
-- Name: cartitems cartitemid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartitems ALTER COLUMN cartitemid SET DEFAULT nextval('public.cartitems_cartitemid_seq'::regclass);


--
-- TOC entry 4925 (class 2604 OID 25413)
-- Name: carts cartid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts ALTER COLUMN cartid SET DEFAULT nextval('public.carts_cartid_seq'::regclass);


--
-- TOC entry 4927 (class 2604 OID 25414)
-- Name: categories categoryid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN categoryid SET DEFAULT nextval('public.categories_categoryid_seq'::regclass);


--
-- TOC entry 4928 (class 2604 OID 25415)
-- Name: chatconversations conversationid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chatconversations ALTER COLUMN conversationid SET DEFAULT nextval('public.chatconversations_conversationid_seq'::regclass);


--
-- TOC entry 4933 (class 2604 OID 25416)
-- Name: chatmessages messageid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chatmessages ALTER COLUMN messageid SET DEFAULT nextval('public.chatmessages_messageid_seq'::regclass);


--
-- TOC entry 4984 (class 2604 OID 25770)
-- Name: contentcategories categoryid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contentcategories ALTER COLUMN categoryid SET DEFAULT nextval('public.contentcategories_categoryid_seq'::regclass);


--
-- TOC entry 5000 (class 2604 OID 25829)
-- Name: customerbehaviors behaviorid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customerbehaviors ALTER COLUMN behaviorid SET DEFAULT nextval('public.customerbehaviors_behaviorid_seq'::regclass);


--
-- TOC entry 4993 (class 2604 OID 25804)
-- Name: faqitems faqid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faqitems ALTER COLUMN faqid SET DEFAULT nextval('public.faqitems_faqid_seq'::regclass);


--
-- TOC entry 5004 (class 2604 OID 25865)
-- Name: homepagebanners bannerid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.homepagebanners ALTER COLUMN bannerid SET DEFAULT nextval('public.homepagebanners_bannerid_seq'::regclass);


--
-- TOC entry 5017 (class 2604 OID 25928)
-- Name: installmentplans planid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.installmentplans ALTER COLUMN planid SET DEFAULT nextval('public.installmentplans_planid_seq'::regclass);


--
-- TOC entry 5023 (class 2604 OID 25942)
-- Name: installmentrequests requestid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.installmentrequests ALTER COLUMN requestid SET DEFAULT nextval('public.installmentrequests_requestid_seq'::regclass);


--
-- TOC entry 5042 (class 2604 OID 26023)
-- Name: loyaltypointtransactions transactionid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loyaltypointtransactions ALTER COLUMN transactionid SET DEFAULT nextval('public.loyaltypointtransactions_transactionid_seq'::regclass);


--
-- TOC entry 4997 (class 2604 OID 25817)
-- Name: marketingcampaigns campaignid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marketingcampaigns ALTER COLUMN campaignid SET DEFAULT nextval('public.marketingcampaigns_campaignid_seq'::regclass);


--
-- TOC entry 4988 (class 2604 OID 25783)
-- Name: newsarticles articleid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.newsarticles ALTER COLUMN articleid SET DEFAULT nextval('public.newsarticles_articleid_seq'::regclass);


--
-- TOC entry 5045 (class 2604 OID 26053)
-- Name: newslettersubscribers subscriberid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.newslettersubscribers ALTER COLUMN subscriberid SET DEFAULT nextval('public.newslettersubscribers_subscriberid_seq'::regclass);


--
-- TOC entry 4973 (class 2604 OID 25713)
-- Name: notifications notificationid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications ALTER COLUMN notificationid SET DEFAULT nextval('public.notifications_notificationid_seq'::regclass);


--
-- TOC entry 4937 (class 2604 OID 25417)
-- Name: orderdetails orderdetailid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderdetails ALTER COLUMN orderdetailid SET DEFAULT nextval('public.orderdetails_orderdetailid_seq'::regclass);


--
-- TOC entry 4938 (class 2604 OID 25418)
-- Name: orders orderid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN orderid SET DEFAULT nextval('public.orders_orderid_seq'::regclass);


--
-- TOC entry 5051 (class 2604 OID 26076)
-- Name: ordershipments shipmentid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordershipments ALTER COLUMN shipmentid SET DEFAULT nextval('public.ordershipments_shipmentid_seq'::regclass);


--
-- TOC entry 4941 (class 2604 OID 25419)
-- Name: orderstatus statusid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderstatus ALTER COLUMN statusid SET DEFAULT nextval('public.orderstatus_statusid_seq'::regclass);


--
-- TOC entry 4942 (class 2604 OID 25420)
-- Name: orderstatushistory historyid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderstatushistory ALTER COLUMN historyid SET DEFAULT nextval('public.orderstatushistory_historyid_seq'::regclass);


--
-- TOC entry 5056 (class 2604 OID 26102)
-- Name: paymenttransactions transactionid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paymenttransactions ALTER COLUMN transactionid SET DEFAULT nextval('public.paymenttransactions_transactionid_seq'::regclass);


--
-- TOC entry 5068 (class 2604 OID 26168)
-- Name: pickupappointments appointmentid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickupappointments ALTER COLUMN appointmentid SET DEFAULT nextval('public.pickupappointments_appointmentid_seq'::regclass);


--
-- TOC entry 4982 (class 2604 OID 25750)
-- Name: productbundleitems bundleitemid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productbundleitems ALTER COLUMN bundleitemid SET DEFAULT nextval('public.productbundleitems_bundleitemid_seq'::regclass);


--
-- TOC entry 4977 (class 2604 OID 25735)
-- Name: productbundles bundleid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productbundles ALTER COLUMN bundleid SET DEFAULT nextval('public.productbundles_bundleid_seq'::regclass);


--
-- TOC entry 4944 (class 2604 OID 25421)
-- Name: productimages imageid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productimages ALTER COLUMN imageid SET DEFAULT nextval('public.productimages_imageid_seq'::regclass);


--
-- TOC entry 5038 (class 2604 OID 26002)
-- Name: productpricealerts alertid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productpricealerts ALTER COLUMN alertid SET DEFAULT nextval('public.productpricealerts_alertid_seq'::regclass);


--
-- TOC entry 4970 (class 2604 OID 25696)
-- Name: productpromotions promotionid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productpromotions ALTER COLUMN promotionid SET DEFAULT nextval('public.productpromotions_promotionid_seq'::regclass);


--
-- TOC entry 4962 (class 2604 OID 25622)
-- Name: productquestions questionid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productquestions ALTER COLUMN questionid SET DEFAULT nextval('public.productquestions_questionid_seq'::regclass);


--
-- TOC entry 4946 (class 2604 OID 25422)
-- Name: products productid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN productid SET DEFAULT nextval('public.products_productid_seq'::regclass);


--
-- TOC entry 4965 (class 2604 OID 25651)
-- Name: productviews viewid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productviews ALTER COLUMN viewid SET DEFAULT nextval('public.productviews_viewid_seq'::regclass);


--
-- TOC entry 5060 (class 2604 OID 26127)
-- Name: refundrequests refundid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refundrequests ALTER COLUMN refundid SET DEFAULT nextval('public.refundrequests_refundid_seq'::regclass);


--
-- TOC entry 4950 (class 2604 OID 25423)
-- Name: reviews reviewid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews ALTER COLUMN reviewid SET DEFAULT nextval('public.reviews_reviewid_seq'::regclass);


--
-- TOC entry 4952 (class 2604 OID 25424)
-- Name: roles roleid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN roleid SET DEFAULT nextval('public.roles_roleid_seq'::regclass);


--
-- TOC entry 5048 (class 2604 OID 26065)
-- Name: shippingproviders providerid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shippingproviders ALTER COLUMN providerid SET DEFAULT nextval('public.shippingproviders_providerid_seq'::regclass);


--
-- TOC entry 4953 (class 2604 OID 25425)
-- Name: specifications specid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specifications ALTER COLUMN specid SET DEFAULT nextval('public.specifications_specid_seq'::regclass);


--
-- TOC entry 4967 (class 2604 OID 25672)
-- Name: stockmovements movementid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stockmovements ALTER COLUMN movementid SET DEFAULT nextval('public.stockmovements_movementid_seq'::regclass);


--
-- TOC entry 5065 (class 2604 OID 26157)
-- Name: storebranches branchid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.storebranches ALTER COLUMN branchid SET DEFAULT nextval('public.storebranches_branchid_seq'::regclass);


--
-- TOC entry 5008 (class 2604 OID 25877)
-- Name: supporttickets ticketid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supporttickets ALTER COLUMN ticketid SET DEFAULT nextval('public.supporttickets_ticketid_seq'::regclass);


--
-- TOC entry 5033 (class 2604 OID 25977)
-- Name: tradeinrequests requestid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tradeinrequests ALTER COLUMN requestid SET DEFAULT nextval('public.tradeinrequests_requestid_seq'::regclass);


--
-- TOC entry 4954 (class 2604 OID 25426)
-- Name: useraddresses addressid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.useraddresses ALTER COLUMN addressid SET DEFAULT nextval('public.useraddresses_addressid_seq'::regclass);


--
-- TOC entry 4959 (class 2604 OID 25427)
-- Name: vouchers voucherid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vouchers ALTER COLUMN voucherid SET DEFAULT nextval('public.vouchers_voucherid_seq'::regclass);


--
-- TOC entry 5012 (class 2604 OID 25894)
-- Name: warrantyrequests warrantyrequestid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warrantyrequests ALTER COLUMN warrantyrequestid SET DEFAULT nextval('public.warrantyrequests_warrantyrequestid_seq'::regclass);


--
-- TOC entry 4960 (class 2604 OID 25600)
-- Name: wishlistitems wishlistitemid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wishlistitems ALTER COLUMN wishlistitemid SET DEFAULT nextval('public.wishlistitems_wishlistitemid_seq'::regclass);


--
-- TOC entry 5529 (class 0 OID 25844)
-- Dependencies: 283
-- Data for Name: adminactivitylogs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.adminactivitylogs (activityid, userid, action, entityname, entityid, note, ipaddress, createdat) FROM stdin;
\.


--
-- TOC entry 5464 (class 0 OID 25296)
-- Dependencies: 218
-- Data for Name: auditlogs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auditlogs (logid, userid, action, createdat) FROM stdin;
\.


--
-- TOC entry 5466 (class 0 OID 25301)
-- Dependencies: 220
-- Data for Name: brands; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.brands (brandid, brandname, country, createdat) FROM stdin;
1	Apple	USA	2026-02-10 15:18:06.040401
2	Samsung	Korea	2026-02-10 15:18:06.040401
3	Xiaomi	China	2026-02-10 15:18:06.040401
4	Oppo	China	2026-02-10 15:18:06.040401
5	Realme	China	2026-06-26 00:32:44.737193
6	Vivo	China	2026-06-26 00:32:44.737193
7	ASUS	Taiwan	2026-06-26 00:32:44.737193
8	Lenovo	China	2026-06-26 00:32:44.737193
9	Sony	Japan	2026-06-26 00:32:44.737193
10	JBL	USA	2026-06-26 00:32:44.737193
11	Anker	China	2026-06-26 00:32:44.737193
12	Garmin	USA	2026-06-26 00:32:44.737193
\.


--
-- TOC entry 5468 (class 0 OID 25306)
-- Dependencies: 222
-- Data for Name: cartitems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cartitems (cartitemid, cartid, productid, quantity) FROM stdin;
8	3	8	1
\.


--
-- TOC entry 5470 (class 0 OID 25310)
-- Dependencies: 224
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.carts (cartid, userid, createdat) FROM stdin;
1	65fde457-3a4f-41da-a63f-1bf14ba153a4	2026-06-22 08:58:31.202166
2	6742622f-8161-4167-bec7-6ee53d86ef07	2026-06-22 11:58:55.344271
3	ff0aa178-b8ac-49a4-8715-d755a3495d24	2026-06-25 10:19:45.021484
\.


--
-- TOC entry 5472 (class 0 OID 25315)
-- Dependencies: 226
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (categoryid, categoryname) FROM stdin;
1	Smartphone
2	Phụ kiện
3	iPhone
4	Samsung Galaxy
5	Xiaomi / Redmi
6	OPPO / Realme
7	Vivo
8	Điện thoại gaming
9	Điện thoại cũ / Like New
10	Tablet / iPad
11	Laptop / MacBook
12	Đồng hồ thông minh
13	Tai nghe
14	Sạc dự phòng
15	Cáp sạc / Củ sạc
16	Ốp lưng / Bao da
17	Phụ kiện công nghệ
18	Thiết bị nhà thông minh
\.


--
-- TOC entry 5474 (class 0 OID 25319)
-- Dependencies: 228
-- Data for Name: chatconversations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chatconversations (conversationid, userid, subject, status, createdat, updatedat, closedat) FROM stdin;
2	ff0aa178-b8ac-49a4-8715-d755a3495d24	Hỗ trợ khách hàng	Open	2026-06-22 12:52:05.536476	2026-06-22 12:52:05.536476	\N
1	6742622f-8161-4167-bec7-6ee53d86ef07	Hỗ trợ khách hàng	Open	2026-06-22 12:50:49.349024	2026-06-22 13:00:24.610975	\N
3	65fde457-3a4f-41da-a63f-1bf14ba153a4	Hỗ trợ khách hàng	Open	2026-06-25 10:17:26.149887	2026-06-25 10:17:26.149887	\N
\.


--
-- TOC entry 5476 (class 0 OID 25327)
-- Dependencies: 230
-- Data for Name: chatmessages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.chatmessages (messageid, conversationid, senderid, message, isread, issystem, createdat) FROM stdin;
1	1	6742622f-8161-4167-bec7-6ee53d86ef07	alo	t	f	2026-06-22 12:52:22.928023
2	1	6742622f-8161-4167-bec7-6ee53d86ef07	tôi muốn mua hàng	t	f	2026-06-22 12:59:44.70336
3	1	ff0aa178-b8ac-49a4-8715-d755a3495d24	bạn cần mua gì	t	f	2026-06-22 12:59:59.498305
4	1	ff0aa178-b8ac-49a4-8715-d755a3495d24	bạn ơi	t	f	2026-06-22 13:00:24.610975
\.


--
-- TOC entry 5519 (class 0 OID 25767)
-- Dependencies: 273
-- Data for Name: contentcategories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contentcategories (categoryid, categoryname, slug, description, isactive, displayorder, createdat) FROM stdin;
1	Tư vấn chọn điện thoại	tu-van-chon-dien-thoai	Bài viết hỗ trợ khách hàng chọn sản phẩm phù hợp.	t	1	2026-06-26 00:13:58.579964
2	Khuyến mãi	khuyen-mai	Tin ưu đãi, flash sale và chương trình bán hàng.	t	2	2026-06-26 00:13:58.579964
3	Hướng dẫn sử dụng	huong-dan-su-dung	Mẹo sử dụng điện thoại và dịch vụ sau bán hàng.	t	3	2026-06-26 00:13:58.579964
\.


--
-- TOC entry 5527 (class 0 OID 25826)
-- Dependencies: 281
-- Data for Name: customerbehaviors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customerbehaviors (behaviorid, userid, sessionid, eventtype, targettype, targetid, keyword, sourceurl, createdat) FROM stdin;
\.


--
-- TOC entry 5523 (class 0 OID 25801)
-- Dependencies: 277
-- Data for Name: faqitems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.faqitems (faqid, question, answer, keywords, groupname, displayorder, isactive, createdat) FROM stdin;
1	PhoneShop có hỗ trợ mua trả góp không?	Có. Khách hàng có thể gửi hồ sơ trả góp tại mục Dịch vụ > Mua trả góp. Admin sẽ kiểm tra và phản hồi trạng thái hồ sơ.	tra gop,mua tra gop,ho so tra gop	Thanh toán	1	t	2026-06-26 00:13:58.579964
2	Tôi kiểm tra vận đơn ở đâu?	Bạn có thể vào Dịch vụ > Tra cứu vận đơn hoặc mục Vận đơn của tôi trong tài khoản để xem trạng thái giao hàng.	van don,giao hang,tracking,ship	Giao hàng	2	t	2026-06-26 00:13:58.579964
3	Chính sách bảo hành như thế nào?	Sản phẩm chính hãng có chính sách bảo hành theo thời hạn của nhà sản xuất. Khách có thể gửi yêu cầu bảo hành/đổi trả trong trang tài khoản hoặc chi tiết đơn hàng.	bao hanh,doi tra,loi san pham	Bảo hành	3	t	2026-06-26 00:13:58.579964
4	Có thể nhận hàng tại cửa hàng không?	Có. Bạn có thể chọn Click & Collect, xem hệ thống cửa hàng và đặt lịch nhận hàng tại mục Dịch vụ > Hệ thống cửa hàng.	nhan hang tai cua hang,click collect,chi nhanh	Nhận hàng	4	t	2026-06-26 00:13:58.579964
\.


--
-- TOC entry 5531 (class 0 OID 25862)
-- Dependencies: 285
-- Data for Name: homepagebanners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.homepagebanners (bannerid, title, subtitle, imageurl, targeturl, badgetext, displayorder, isactive, startat, endat, createdat) FROM stdin;
1	Flash Sale điện thoại chính hãng	Nâng cấp trang chủ bằng banner quản trị được lưu trong database.	\N	/Product	LAN 5	1	t	\N	\N	2026-06-26 00:19:45.284952
2	Hỗ trợ khách hàng sau bán	Khách có thể gửi ticket hỗ trợ và theo dõi phản hồi từ Admin.	\N	/Support	SUPPORT	2	t	\N	\N	2026-06-26 00:19:45.284952
3	Bảo hành và đổi trả rõ ràng	Tạo yêu cầu bảo hành/đổi trả từ lịch sử đơn hàng.	\N	/Support/WarrantyPolicy	WARRANTY	3	t	\N	\N	2026-06-26 00:19:45.284952
4	Lan9 Mega Tech Store	Giao diện mới với navbar tối ưu, mega menu danh mục, nhiều nhóm sản phẩm và trải nghiệm mua sắm hiện đại.	\N	/Product	LAN9 UI	1	t	2026-06-26 00:32:44.737193	2026-08-25 00:32:44.737193	2026-06-26 00:32:44.737193
5	Phụ kiện mua kèm giá tốt	Tai nghe, sạc nhanh, ốp lưng, đồng hồ thông minh và thiết bị nhà thông minh.	\N	/Product	ADD-ON	2	t	2026-06-26 00:32:44.737193	2026-08-25 00:32:44.737193	2026-06-26 00:32:44.737193
\.


--
-- TOC entry 5537 (class 0 OID 25925)
-- Dependencies: 291
-- Data for Name: installmentplans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.installmentplans (planid, planname, termmonths, interestpercent, minprepaidpercent, isactive, displayorder, createdat) FROM stdin;
1	Trả góp 0% ngắn hạn	3	0.00	30.00	t	1	2026-06-26 00:21:03.701957
2	Trả góp tiêu chuẩn	6	3.50	25.00	t	2	2026-06-26 00:21:03.701957
3	Trả góp linh hoạt	12	7.50	20.00	t	3	2026-06-26 00:21:03.701957
\.


--
-- TOC entry 5539 (class 0 OID 25939)
-- Dependencies: 293
-- Data for Name: installmentrequests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.installmentrequests (requestid, userid, productid, planid, productprice, prepaidamount, termmonths, interestpercent, monthlypayment, totalpayment, customerphone, customerjob, customerincome, idcardlast4, status, adminnote, createdat, updatedat) FROM stdin;
\.


--
-- TOC entry 5545 (class 0 OID 26020)
-- Dependencies: 299
-- Data for Name: loyaltypointtransactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.loyaltypointtransactions (transactionid, userid, orderid, points, transactiontype, note, createdat) FROM stdin;
1	65fde457-3a4f-41da-a63f-1bf14ba153a4	2	349	Earn	Cộng điểm tự động từ dữ liệu đơn hàng cũ ORD-20260622094719-9421	2026-06-22 09:47:19.728074
2	65fde457-3a4f-41da-a63f-1bf14ba153a4	1	639	Earn	Cộng điểm tự động từ dữ liệu đơn hàng cũ ORD-20260622090244-2617	2026-06-22 09:02:44.691549
3	6742622f-8161-4167-bec7-6ee53d86ef07	3	1	Earn	Cộng điểm tự động từ dữ liệu đơn hàng cũ ORD-20260622115915-8662	2026-06-22 11:59:15.68769
4	6742622f-8161-4167-bec7-6ee53d86ef07	5	129	Earn	Cộng điểm tự động từ dữ liệu đơn hàng cũ ORD-20260622120456-6168	2026-06-22 12:04:56.655548
5	6742622f-8161-4167-bec7-6ee53d86ef07	4	1	Earn	Cộng điểm tự động từ dữ liệu đơn hàng cũ ORD-20260622120402-8863	2026-06-22 12:04:02.761423
\.


--
-- TOC entry 5525 (class 0 OID 25814)
-- Dependencies: 279
-- Data for Name: marketingcampaigns; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.marketingcampaigns (campaignid, campaignname, channel, targetsegment, status, budget, message, landingurl, startat, endat, createdat) FROM stdin;
1	Lan8 Combo Launch	Banner	Khách truy cập trang chủ	Running	0.00	Ra mắt combo điện thoại và phụ kiện với giá tiết kiệm.	/Bundle	2026-06-26 00:13:58.579964	2026-07-26 00:13:58.579964	2026-06-26 00:13:58.579964
\.


--
-- TOC entry 5521 (class 0 OID 25780)
-- Dependencies: 275
-- Data for Name: newsarticles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.newsarticles (articleid, categoryid, title, slug, summary, content, imageurl, authorname, tags, ispublished, viewcount, publishedat, createdat, updatedat) FROM stdin;
1	1	Cách chọn điện thoại phù hợp với nhu cầu học tập và làm việc	cach-chon-dien-thoai-phu-hop	Gợi ý các tiêu chí quan trọng khi chọn điện thoại: hiệu năng, pin, camera, bộ nhớ và ngân sách.	Khi chọn điện thoại, khách hàng nên xác định nhu cầu chính trước: học tập, làm việc, chơi game hay chụp ảnh. Với nhu cầu cơ bản, nên ưu tiên pin tốt và bộ nhớ đủ lớn. Với nhu cầu chơi game, nên quan tâm chip xử lý, RAM và tản nhiệt. Với nhu cầu chụp ảnh, nên xem chất lượng camera, chống rung và thuật toán xử lý ảnh.	\N	PhoneShop Admin	tu van,chon dien thoai,smartphone	t	0	2026-06-26 00:13:58.579964	2026-06-26 00:13:58.579964	2026-06-26 00:13:58.579964
2	2	Những lợi ích khi mua combo điện thoại và phụ kiện	loi-ich-khi-mua-combo-dien-thoai-phu-kien	Combo giúp khách tiết kiệm thời gian chọn phụ kiện và tối ưu chi phí mua hàng.	Combo sản phẩm thường bao gồm điện thoại, ốp lưng, cường lực hoặc phụ kiện sạc. Với website thương mại điện tử, combo giúp tăng giá trị đơn hàng, tạo trải nghiệm chọn mua nhanh và làm nổi bật chương trình khuyến mãi.	\N	PhoneShop Admin	combo,phu kien,khuyen mai	t	0	2026-06-26 00:13:58.579964	2026-06-26 00:13:58.579964	2026-06-26 00:13:58.579964
\.


--
-- TOC entry 5548 (class 0 OID 26050)
-- Dependencies: 302
-- Data for Name: newslettersubscribers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.newslettersubscribers (subscriberid, email, fullname, isactive, subscribedat) FROM stdin;
\.


--
-- TOC entry 5513 (class 0 OID 25710)
-- Dependencies: 267
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (notificationid, userid, title, message, type, targeturl, isread, createdat) FROM stdin;
1	65fde457-3a4f-41da-a63f-1bf14ba153a4	Đặt hàng thành công	Đơn hàng OD2606251020209742 đã được tạo và đang chờ xác nhận.	Order	/Order/Details/6	f	2026-06-25 10:20:20.458661
2	65fde457-3a4f-41da-a63f-1bf14ba153a4	Cập nhật đơn hàng	Đơn hàng OD2606251020209742 đã chuyển sang trạng thái Đã xác nhận.	Order	/Order/Details/6	t	2026-06-25 10:20:49.266076
\.


--
-- TOC entry 5478 (class 0 OID 25336)
-- Dependencies: 232
-- Data for Name: orderdetails; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orderdetails (orderdetailid, orderid, productid, quantity, price) FROM stdin;
1	1	2	2	31990000.00
2	2	1	1	34990000.00
3	3	5	1	100000.00
4	4	5	1	100000.00
5	5	4	1	12990000.00
6	6	8	2	184000000.00
\.


--
-- TOC entry 5480 (class 0 OID 25340)
-- Dependencies: 234
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (orderid, userid, ordercode, totalamount, status, paymentmethod, createdat, voucherid, receivername, receiverphone, shippingaddress, note, subtotalamount, discountamount) FROM stdin;
2	65fde457-3a4f-41da-a63f-1bf14ba153a4	ORD-20260622094719-9421	34990000.00	Completed	COD	2026-06-22 09:47:19.728074	\N	Từ Đức Duy	0374705913	Minh Khai	hhahaha	34990000.00	0.00
1	65fde457-3a4f-41da-a63f-1bf14ba153a4	ORD-20260622090244-2617	63980000.00	Completed	COD	2026-06-22 09:02:44.691549	\N	\N	\N	\N	\N	63980000.00	0.00
3	6742622f-8161-4167-bec7-6ee53d86ef07	ORD-20260622115915-8662	100000.00	Completed	COD	2026-06-22 11:59:15.68769	\N	Nguyễn văn A	0374705913	Hà Nội	\N	100000.00	0.00
5	6742622f-8161-4167-bec7-6ee53d86ef07	ORD-20260622120456-6168	12990000.00	Completed	COD	2026-06-22 12:04:56.655548	\N	Từ Đức DUy	0374705913	Minh Khai	haha	12990000.00	0.00
4	6742622f-8161-4167-bec7-6ee53d86ef07	ORD-20260622120402-8863	100000.00	Completed	COD	2026-06-22 12:04:02.761423	\N	Nguyễn Văn A	0374705913	Minh Khai	\N	100000.00	0.00
6	65fde457-3a4f-41da-a63f-1bf14ba153a4	OD2606251020209742	367500000.00	Confirmed	COD	2026-06-25 10:20:20.323451	1	tuducduy	0374705913	Hà nội	\N	368000000.00	500000.00
\.


--
-- TOC entry 5552 (class 0 OID 26073)
-- Dependencies: 306
-- Data for Name: ordershipments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ordershipments (shipmentid, orderid, providerid, trackingnumber, shippingfee, shiptoaddress, status, estimateddeliverydate, shippedat, deliveredat, adminnote, createdat, updatedat) FROM stdin;
\.


--
-- TOC entry 5482 (class 0 OID 25347)
-- Dependencies: 236
-- Data for Name: orderstatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orderstatus (statusid, statusname) FROM stdin;
1	Pending
2	Confirmed
3	Shipping
4	Completed
5	Cancelled
\.


--
-- TOC entry 5484 (class 0 OID 25351)
-- Dependencies: 238
-- Data for Name: orderstatushistory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orderstatushistory (historyid, orderid, statusid, changedat) FROM stdin;
1	2	4	2026-06-22 09:47:19.728074
2	5	4	2026-06-22 12:04:56.655548
3	4	4	2026-06-22 12:04:02.761423
4	1	4	2026-06-22 09:02:44.691549
5	3	4	2026-06-22 11:59:15.68769
6	6	1	2026-06-25 10:20:20.44279
7	6	2	2026-06-25 10:20:49.265538
\.


--
-- TOC entry 5554 (class 0 OID 26099)
-- Dependencies: 308
-- Data for Name: paymenttransactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.paymenttransactions (transactionid, orderid, userid, transactioncode, paymentmethod, amount, status, gatewayname, note, createdat) FROM stdin;
1	2	65fde457-3a4f-41da-a63f-1bf14ba153a4	PAY20260622-2	COD	34990000.00	Paid	System Seed	Giao dịch sinh tự động khi nâng cấp Lan7	2026-06-22 09:47:19.728074
2	1	65fde457-3a4f-41da-a63f-1bf14ba153a4	PAY20260622-1	COD	63980000.00	Paid	System Seed	Giao dịch sinh tự động khi nâng cấp Lan7	2026-06-22 09:02:44.691549
3	3	6742622f-8161-4167-bec7-6ee53d86ef07	PAY20260622-3	COD	100000.00	Paid	System Seed	Giao dịch sinh tự động khi nâng cấp Lan7	2026-06-22 11:59:15.68769
4	5	6742622f-8161-4167-bec7-6ee53d86ef07	PAY20260622-5	COD	12990000.00	Paid	System Seed	Giao dịch sinh tự động khi nâng cấp Lan7	2026-06-22 12:04:56.655548
5	4	6742622f-8161-4167-bec7-6ee53d86ef07	PAY20260622-4	COD	100000.00	Paid	System Seed	Giao dịch sinh tự động khi nâng cấp Lan7	2026-06-22 12:04:02.761423
6	6	65fde457-3a4f-41da-a63f-1bf14ba153a4	PAY20260625-6	COD	367500000.00	Pending	System Seed	Giao dịch sinh tự động khi nâng cấp Lan7	2026-06-25 10:20:20.323451
\.


--
-- TOC entry 5560 (class 0 OID 26165)
-- Dependencies: 314
-- Data for Name: pickupappointments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pickupappointments (appointmentid, userid, orderid, branchid, appointmentdate, timeslot, status, note, adminnote, createdat, updatedat) FROM stdin;
\.


--
-- TOC entry 5517 (class 0 OID 25747)
-- Dependencies: 271
-- Data for Name: productbundleitems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productbundleitems (bundleitemid, bundleid, productid, quantity) FROM stdin;
1	1	1	1
2	1	2	1
\.


--
-- TOC entry 5515 (class 0 OID 25732)
-- Dependencies: 269
-- Data for Name: productbundles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productbundles (bundleid, bundlename, slug, description, coverimageurl, originalprice, bundleprice, badgetext, isactive, displayorder, startat, endat, createdat) FROM stdin;
1	Combo tiết kiệm PhoneShop	combo-tiet-kiem-phoneshop	Bộ sản phẩm gợi ý giúp khách hàng mua nhanh hơn trong quá trình demo.	\N	66980000.00	66680000.00	Lan8 Deal	t	1	2026-06-26 00:13:58.579964	2026-07-26 00:13:58.579964	2026-06-26 00:13:58.579964
\.


--
-- TOC entry 5486 (class 0 OID 25356)
-- Dependencies: 240
-- Data for Name: productimages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productimages (imageid, productid, imageurl, ismain) FROM stdin;
1	1	/images/iphone15.jpg	t
2	2	/images/s24.jpg	t
3	3	/images/xiaomi14.jpg	t
4	4	/images/opporeno11.jpg	t
\.


--
-- TOC entry 5543 (class 0 OID 25999)
-- Dependencies: 297
-- Data for Name: productpricealerts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productpricealerts (alertid, userid, productid, targetprice, isactive, isnotified, createdat, notifiedat) FROM stdin;
\.


--
-- TOC entry 5511 (class 0 OID 25693)
-- Dependencies: 265
-- Data for Name: productpromotions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productpromotions (promotionid, productid, title, badgetext, discountpercent, saleprice, startat, endat, isactive, createdat) FROM stdin;
1	8	Flash Sale mùa bảo vệ đồ án	Flash Sale	8	\N	2026-06-24 10:09:48.10835	2026-07-25 10:09:48.10835	t	2026-06-25 10:09:48.10835
2	7	Flash Sale mùa bảo vệ đồ án	Flash Sale	8	\N	2026-06-24 10:09:48.10835	2026-07-25 10:09:48.10835	t	2026-06-25 10:09:48.10835
3	6	Flash Sale mùa bảo vệ đồ án	Flash Sale	8	\N	2026-06-24 10:09:48.10835	2026-07-25 10:09:48.10835	t	2026-06-25 10:09:48.10835
4	5	Flash Sale mùa bảo vệ đồ án	Flash Sale	8	\N	2026-06-24 10:09:48.10835	2026-07-25 10:09:48.10835	t	2026-06-25 10:09:48.10835
5	4	Flash Sale mùa bảo vệ đồ án	Flash Sale	8	\N	2026-06-24 10:09:48.10835	2026-07-25 10:09:48.10835	t	2026-06-25 10:09:48.10835
6	3	Flash Sale mùa bảo vệ đồ án	Flash Sale	8	\N	2026-06-24 10:09:48.10835	2026-07-25 10:09:48.10835	t	2026-06-25 10:09:48.10835
7	2	Flash Sale mùa bảo vệ đồ án	Flash Sale	8	\N	2026-06-24 10:10:23.886685	2026-07-25 10:10:23.886685	t	2026-06-25 10:10:23.886685
8	1	Flash Sale mùa bảo vệ đồ án	Flash Sale	8	\N	2026-06-24 10:10:23.886685	2026-07-25 10:10:23.886685	t	2026-06-25 10:10:23.886685
9	9	Lan9 iPhone Deal	Giảm sốc	5	\N	2026-06-26 00:32:44.737193	2026-07-26 00:32:44.737193	t	2026-06-26 00:32:44.737193
10	11	Lan9 Samsung Deal	Hot Deal	7	\N	2026-06-26 00:32:44.737193	2026-07-26 00:32:44.737193	t	2026-06-26 00:32:44.737193
11	26	Lan9 Accessory Deal	Phụ kiện	10	\N	2026-06-26 00:32:44.737193	2026-07-26 00:32:44.737193	t	2026-06-26 00:32:44.737193
12	31	Flash Sale điện thoại	Flash Sale	8	\N	2026-06-25 00:38:04.689489	2026-07-26 00:38:04.689489	t	2026-06-26 00:38:04.689489
13	30	Flash Sale điện thoại	Flash Sale	8	\N	2026-06-25 00:38:04.689489	2026-07-26 00:38:04.689489	t	2026-06-26 00:38:04.689489
14	29	Flash Sale điện thoại	Flash Sale	8	\N	2026-06-25 00:38:04.689489	2026-07-26 00:38:04.689489	t	2026-06-26 00:38:04.689489
15	28	Flash Sale điện thoại	Flash Sale	8	\N	2026-06-25 00:38:04.689489	2026-07-26 00:38:04.689489	t	2026-06-26 00:38:04.689489
16	27	Flash Sale điện thoại	Flash Sale	8	\N	2026-06-25 00:38:04.689489	2026-07-26 00:38:04.689489	t	2026-06-26 00:38:04.689489
17	26	Flash Sale điện thoại	Flash Sale	8	\N	2026-06-25 00:38:04.689489	2026-07-26 00:38:04.689489	t	2026-06-26 00:38:04.689489
18	25	Flash Sale điện thoại	Flash Sale	8	\N	2026-06-25 00:38:26.528972	2026-07-26 00:38:26.528972	t	2026-06-26 00:38:26.528972
19	24	Flash Sale điện thoại	Flash Sale	8	\N	2026-06-25 00:38:26.528972	2026-07-26 00:38:26.528972	t	2026-06-26 00:38:26.528972
20	23	Flash Sale điện thoại	Flash Sale	8	\N	2026-06-25 00:38:26.528972	2026-07-26 00:38:26.528972	t	2026-06-26 00:38:26.528972
21	22	Flash Sale điện thoại	Flash Sale	8	\N	2026-06-25 00:38:26.528972	2026-07-26 00:38:26.528972	t	2026-06-26 00:38:26.528972
22	21	Flash Sale điện thoại	Flash Sale	8	\N	2026-06-25 00:38:26.528972	2026-07-26 00:38:26.528972	t	2026-06-26 00:38:26.528972
23	20	Flash Sale điện thoại	Flash Sale	8	\N	2026-06-25 00:38:26.528972	2026-07-26 00:38:26.528972	t	2026-06-26 00:38:26.528972
24	19	Flash Sale điện thoại	Flash Sale	8	\N	2026-06-25 00:38:27.629942	2026-07-26 00:38:27.629942	t	2026-06-26 00:38:27.629942
25	18	Flash Sale điện thoại	Flash Sale	8	\N	2026-06-25 00:38:27.629942	2026-07-26 00:38:27.629942	t	2026-06-26 00:38:27.629942
26	17	Flash Sale điện thoại	Flash Sale	8	\N	2026-06-25 00:38:27.629942	2026-07-26 00:38:27.629942	t	2026-06-26 00:38:27.629942
27	16	Flash Sale điện thoại	Flash Sale	8	\N	2026-06-25 00:38:27.629942	2026-07-26 00:38:27.629942	t	2026-06-26 00:38:27.629942
28	15	Flash Sale điện thoại	Flash Sale	8	\N	2026-06-25 00:38:27.629942	2026-07-26 00:38:27.629942	t	2026-06-26 00:38:27.629942
29	14	Flash Sale điện thoại	Flash Sale	8	\N	2026-06-25 00:38:27.629942	2026-07-26 00:38:27.629942	t	2026-06-26 00:38:27.629942
30	13	Flash Sale mùa bảo vệ đồ án	Flash Sale	8	\N	2026-06-25 00:40:37.530141	2026-07-26 00:40:37.530141	t	2026-06-26 00:40:37.530141
31	12	Flash Sale mùa bảo vệ đồ án	Flash Sale	8	\N	2026-06-25 00:40:37.530141	2026-07-26 00:40:37.530141	t	2026-06-26 00:40:37.530141
32	10	Flash Sale mùa bảo vệ đồ án	Flash Sale	8	\N	2026-06-25 00:40:37.530141	2026-07-26 00:40:37.530141	t	2026-06-26 00:40:37.530141
\.


--
-- TOC entry 5505 (class 0 OID 25619)
-- Dependencies: 259
-- Data for Name: productquestions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productquestions (questionid, productid, userid, question, answer, answeredbyuserid, isvisible, createdat, answeredat) FROM stdin;
1	3	\N	Sản phẩm này có hỗ trợ trả góp không?	Có. PhoneShop có thể hiển thị chính sách trả góp 0% trong giao diện bán hàng.	\N	t	2026-06-25 10:09:48.10835	2026-06-25 10:09:48.10835
2	2	\N	Sản phẩm này có hỗ trợ trả góp không?	Có. PhoneShop có thể hiển thị chính sách trả góp 0% trong giao diện bán hàng.	\N	t	2026-06-25 10:09:48.10835	2026-06-25 10:09:48.10835
3	1	\N	Sản phẩm này có hỗ trợ trả góp không?	Có. PhoneShop có thể hiển thị chính sách trả góp 0% trong giao diện bán hàng.	\N	t	2026-06-25 10:09:48.10835	2026-06-25 10:09:48.10835
4	5	\N	Sản phẩm này có hỗ trợ trả góp không?	Có. PhoneShop có thể hiển thị chính sách trả góp 0% trong giao diện bán hàng.	\N	t	2026-06-25 10:10:23.886685	2026-06-25 10:10:23.886685
5	4	\N	Sản phẩm này có hỗ trợ trả góp không?	Có. PhoneShop có thể hiển thị chính sách trả góp 0% trong giao diện bán hàng.	\N	t	2026-06-25 10:10:23.886685	2026-06-25 10:10:23.886685
6	6	\N	Sản phẩm này có hỗ trợ trả góp không?	Có. PhoneShop có thể hiển thị chính sách trả góp 0% trong giao diện bán hàng.	\N	t	2026-06-25 10:10:23.886685	2026-06-25 10:10:23.886685
7	7	\N	Sản phẩm này có hỗ trợ trả góp không?	Có. PhoneShop có thể hiển thị chính sách trả góp 0% trong giao diện bán hàng.	\N	t	2026-06-26 00:40:37.530141	2026-06-26 00:40:37.530141
8	8	\N	Sản phẩm này có hỗ trợ trả góp không?	Có. PhoneShop có thể hiển thị chính sách trả góp 0% trong giao diện bán hàng.	\N	t	2026-06-26 00:40:37.530141	2026-06-26 00:40:37.530141
9	9	\N	Sản phẩm này có hỗ trợ trả góp không?	Có. PhoneShop có thể hiển thị chính sách trả góp 0% trong giao diện bán hàng.	\N	t	2026-06-26 00:40:37.530141	2026-06-26 00:40:37.530141
\.


--
-- TOC entry 5488 (class 0 OID 25363)
-- Dependencies: 242
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (productid, productname, price, quantity, description, imageurl, brandid, categoryid, isactive, createdat) FROM stdin;
3	Xiaomi 14	18990000.00	30	Hi?u nang cao gi  t?t	/images/xiaomi14.jpg	3	1	t	2026-02-10 15:54:44.115118
2	Samsung Galaxy S24 Ultra	31990000.00	13	Samsung Galaxy S24 Ultra là mẫu điện thoại cao cấp nhất trong dòng Galaxy S24 của Samsung, ra mắt vào tháng 1 năm 2024. Máy được thiết kế với khung viền Titanium, tích hợp bút S Pen và hỗ trợ nhiều tính năng AI.\n\nThông số kỹ thuật\nMàn hình: Dynamic AMOLED 2X 6,8 inch\nĐộ phân giải: QHD+ (3120 × 1440 pixel)\nTần số quét: 1–120 Hz thích ứng\nĐộ sáng tối đa: 2.600 nit\nVi xử lý: Qualcomm Snapdragon 8 Gen 3 for Galaxy\nRAM: 12 GB\nBộ nhớ trong: 256 GB, 512 GB hoặc 1 TB\nHệ điều hành khi xuất xưởng: Android 14 với giao diện One UI 6.1\nHỗ trợ cập nhật: 7 năm hệ điều hành và bảo mật\nCamera\nCamera chính: 200 MP (góc rộng)\nCamera góc siêu rộng: 12 MP\nCamera tele 3x: 10 MP\nCamera tele 5x: 50 MP\nCamera trước: 12 MP\n\nMáy hỗ trợ quay video 8K, zoom quang học 3x và 5x, zoom kỹ thuật số lên đến 100x.\n\nPin và sạc\nDung lượng pin: 5.000 mAh\nSạc nhanh có dây: 45 W\nSạc không dây: 15 W\nHỗ trợ sạc ngược không dây\nThiết kế\nKích thước: 162,3 × 79,0 × 8,6 mm\nTrọng lượng: khoảng 232 g\nKhung Titanium\nMặt kính Gorilla Glass Armor\nChuẩn kháng nước và bụi IP68\nTích hợp bút S Pen bên trong thân máy\nKết nối\n5G\nWi-Fi 7\nBluetooth 5.3\nNFC\nUSB Type-C 3.2\nMột số tính năng nổi bật\nGalaxy AI: Dịch trực tiếp cuộc gọi, tóm tắt ghi chú, chỉnh sửa ảnh bằng AI, tìm kiếm bằng cách khoanh vùng (Circle to Search).\nCảm biến vân tay siêu âm dưới màn hình.\nLoa kép tinh chỉnh bởi AKG.\nSamsung DeX giúp biến điện thoại thành môi trường làm việc như máy tính.\nMàu sắc\nTitanium Gray (Xám Titanium)\nTitanium Black (Đen Titanium)\nTitanium Violet (Tím Titanium)\nTitanium Yellow (Vàng Titanium)\nMột số màu độc quyền khi đặt hàng từ Samsung: Titanium Blue, Titanium Green và Titanium Orange.\n\nSamsung Galaxy S24 Ultra phù hợp với người dùng cần hiệu năng mạnh, camera chất lượng cao, thời lượng pin tốt và muốn sử dụng bút S Pen cho công việc hoặc ghi chú.	/images/s24.jpg	2	1	t	2026-02-10 15:54:44.115118
1	iPhone 17 Pro Max	34990000.00	19	Iphone cao cấp nhất hiện nay	/images/iphone15.jpg	1	1	t	2026-02-10 15:54:44.115118
5	Ip16	100000.00	8	1111111	/uploads/2e43b40b70aa4d24900f233f538b9a6d.jpg	1	1	t	2026-06-22 09:14:13.14507
4	OPPO Reno 11	12990000.00	24	Camera chƒn dung d?p	/images/opporeno11.jpg	4	1	t	2026-02-10 15:54:44.115118
6	Redmi 11	29000000.00	5	1111	/uploads/c4b26bbfb00944c99b34114bbe0b9b39.jpg	3	1	t	2026-06-22 13:42:08.61755
7	Samsung s24 Utral	200000000.00	5	111111111111111	/uploads/9bcc7252399f4ff6aac1a58f73fbfb8e.jpg	2	1	t	2026-06-22 13:42:49.765483
8	Samsung s23	200000000.00	1	aaaaaaaaaaaaaaaaaaaa	/uploads/bd82cc2a624a4f579261abc41325c32e.jpg	2	1	t	2026-06-22 13:43:24.268499
9	iPhone 16 Pro Max 256GB	34990000.00	24	Màn hình ProMotion, chip mạnh, camera cao cấp, phù hợp nhóm khách hàng cao cấp.	/images/ip16.jpg	1	3	t	2026-06-26 00:32:44.737193
10	iPhone 15 128GB	18990000.00	35	Mẫu iPhone phổ biến, thiết kế đẹp, hiệu năng ổn định, dễ bán trong demo.	/images/iphone15.jpg	1	3	t	2026-06-26 00:32:44.737193
11	Samsung Galaxy S24 Ultra 256GB	29990000.00	18	Flagship Android với bút S Pen, camera zoom xa và màn hình lớn.	/images/s24.jpg	2	4	t	2026-06-26 00:32:44.737193
12	Samsung Galaxy S23 FE	11990000.00	28	Dòng Samsung hiệu năng tốt, giá dễ tiếp cận, phù hợp phân khúc tầm trung.	/images/s23.jpg	2	4	t	2026-06-26 00:32:44.737193
13	Xiaomi 14 5G	18990000.00	22	Điện thoại Xiaomi hiệu năng cao, camera đẹp, sạc nhanh.	/images/xiaomi14.jpg	3	5	t	2026-06-26 00:32:44.737193
14	Redmi Note 13 Pro	7490000.00	42	Mẫu Redmi giá tốt, pin khỏe, màn hình lớn, phù hợp học sinh sinh viên.	/images/redmi11.jpg	3	5	t	2026-06-26 00:32:44.737193
15	OPPO Reno11 F 5G	8990000.00	30	Thiết kế mỏng nhẹ, camera chân dung đẹp, sạc nhanh.	/images/opporeno11.jpg	4	6	t	2026-06-26 00:32:44.737193
16	Realme 12 Pro Plus	10990000.00	20	Điện thoại tầm trung nổi bật về camera và hiệu năng.	/images/opporeno11.jpg	5	6	t	2026-06-26 00:32:44.737193
17	Vivo V30 5G	11990000.00	18	Thiết kế đẹp, camera selfie tốt, phù hợp khách hàng trẻ.	/images/s22.jpg	6	7	t	2026-06-26 00:32:44.737193
18	ASUS ROG Phone 8	23990000.00	12	Điện thoại gaming hiệu năng mạnh, màn hình tần số quét cao.	/images/s24.jpg	7	8	t	2026-06-26 00:32:44.737193
19	iPhone 13 Like New 99%	10990000.00	15	Máy Like New dành cho khách muốn iPhone giá tốt.	/images/iphone15.jpg	1	9	t	2026-06-26 00:32:44.737193
20	iPad Gen 10 WiFi 64GB	8990000.00	20	Máy tính bảng học tập, giải trí và làm việc cơ bản.	/images/ip16.jpg	1	10	t	2026-06-26 00:32:44.737193
21	Samsung Galaxy Tab S9 FE	9990000.00	14	Tablet Samsung màn hình lớn, bút hỗ trợ học tập và ghi chú.	/images/s23.jpg	2	10	t	2026-06-26 00:32:44.737193
22	MacBook Air M2 13 inch	22990000.00	8	Laptop mỏng nhẹ, pin tốt, phù hợp học tập và văn phòng.	/images/ip16.jpg	1	11	t	2026-06-26 00:32:44.737193
23	Lenovo IdeaPad Slim 5	15990000.00	10	Laptop văn phòng, học tập, cấu hình ổn và giá dễ tiếp cận.	/images/xiaomi14.jpg	8	11	t	2026-06-26 00:32:44.737193
24	Apple Watch Series 9	9490000.00	16	Đồng hồ thông minh theo dõi sức khỏe, thông báo và luyện tập.	/images/iphone15.jpg	1	12	t	2026-06-26 00:32:44.737193
25	Garmin Forerunner 165	6990000.00	10	Đồng hồ thể thao cho chạy bộ, luyện tập và sức khỏe.	/images/s22.jpg	12	12	t	2026-06-26 00:32:44.737193
26	AirPods Pro 2	5490000.00	28	Tai nghe chống ồn, kết nối nhanh, âm thanh tốt.	/images/ip16.jpg	1	13	t	2026-06-26 00:32:44.737193
27	JBL Tune Beam	1990000.00	35	Tai nghe true wireless giá tốt, âm bass mạnh.	/images/s24.jpg	10	13	t	2026-06-26 00:32:44.737193
28	Anker PowerCore 20000mAh	1290000.00	40	Sạc dự phòng dung lượng lớn, phù hợp đi học và du lịch.	/images/xiaomi14.jpg	11	14	t	2026-06-26 00:32:44.737193
29	Củ sạc nhanh 30W USB-C	490000.00	60	Củ sạc nhanh cho iPhone, Android và tablet.	/images/redmi11.jpg	11	15	t	2026-06-26 00:32:44.737193
30	Ốp lưng chống sốc iPhone	250000.00	100	Ốp lưng bảo vệ máy, nhiều màu, phù hợp bán kèm.	/images/iphone15.jpg	1	16	t	2026-06-26 00:32:44.737193
31	Camera thông minh WiFi	790000.00	25	Thiết bị nhà thông minh hỗ trợ giám sát từ xa.	/images/opporeno11.jpg	3	18	t	2026-06-26 00:32:44.737193
\.


--
-- TOC entry 5490 (class 0 OID 25372)
-- Dependencies: 244
-- Data for Name: productspecifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productspecifications (productid, specid, specvalue) FROM stdin;
\.


--
-- TOC entry 5507 (class 0 OID 25648)
-- Dependencies: 261
-- Data for Name: productviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productviews (viewid, productid, userid, sessionkey, viewedat) FROM stdin;
1	8	65fde457-3a4f-41da-a63f-1bf14ba153a4	c537152f2d674daaae3154bc90848a20	2026-06-25 10:16:27.302842
2	8	ff0aa178-b8ac-49a4-8715-d755a3495d24	f447341a23c54e63a784924cfca1715d	2026-06-25 10:19:29.902125
\.


--
-- TOC entry 5556 (class 0 OID 26124)
-- Dependencies: 310
-- Data for Name: refundrequests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.refundrequests (refundid, orderid, userid, paymenttransactionid, amount, reason, status, adminnote, createdat, updatedat) FROM stdin;
\.


--
-- TOC entry 5491 (class 0 OID 25375)
-- Dependencies: 245
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (reviewid, productid, userid, rating, comment, createdat) FROM stdin;
1	8	65fde457-3a4f-41da-a63f-1bf14ba153a4	5	aaaaaa	2026-06-25 10:21:25.359203
2	19	ff0aa178-b8ac-49a4-8715-d755a3495d24	5	yhhhh	2026-06-26 09:23:56.251533
\.


--
-- TOC entry 5493 (class 0 OID 25383)
-- Dependencies: 247
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (roleid, rolename) FROM stdin;
1	Admin
2	User
3	Customer
\.


--
-- TOC entry 5550 (class 0 OID 26062)
-- Dependencies: 304
-- Data for Name: shippingproviders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shippingproviders (providerid, providername, hotline, trackingurltemplate, isactive, createdat) FROM stdin;
1	Giao hàng nhanh	1900636677	https://ghn.vn/tracking?order_code={tracking}	t	2026-06-26 00:21:18.747823
2	Viettel Post	19008095	https://viettelpost.com.vn/tra-cuu-hanh-trinh-don/?orderNumber={tracking}	t	2026-06-26 00:21:18.747823
3	J&T Express	19001088	https://jtexpress.vn/vi/tracking?type=track&billcode={tracking}	t	2026-06-26 00:21:18.747823
\.


--
-- TOC entry 5546 (class 0 OID 26041)
-- Dependencies: 300
-- Data for Name: siteconfigs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.siteconfigs (configkey, configvalue, groupname, description, updatedat) FROM stdin;
store_name	PhoneShop	General	Tên cửa hàng hiển thị trên website	2026-06-26 00:21:03.701957
store_hotline	0123 456 789	Contact	Số điện thoại hỗ trợ khách hàng	2026-06-26 00:21:03.701957
store_email	support@phoneshop.vn	Contact	Email hỗ trợ	2026-06-26 00:21:03.701957
shipping_policy_short	Giao nhanh, kiểm tra hàng trước khi nhận	Policy	Mô tả ngắn chính sách giao hàng	2026-06-26 00:21:03.701957
loyalty_rate_note	Hoàn 1 điểm cho mỗi 100.000đ khi đơn hoàn thành	Loyalty	Ghi chú cách tính điểm	2026-06-26 00:21:03.701957
\.


--
-- TOC entry 5495 (class 0 OID 25387)
-- Dependencies: 249
-- Data for Name: specifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.specifications (specid, specname) FROM stdin;
1	Màn hình
2	Chip xử lý
3	RAM
4	Bộ nhớ trong
5	Camera sau
6	Camera trước
7	Pin
8	Sạc nhanh
9	Hệ điều hành
10	Bảo hành
\.


--
-- TOC entry 5509 (class 0 OID 25669)
-- Dependencies: 263
-- Data for Name: stockmovements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stockmovements (movementid, productid, userid, movementtype, quantitychange, quantitybefore, quantityafter, referencecode, note, createdat) FROM stdin;
1	8	65fde457-3a4f-41da-a63f-1bf14ba153a4	Sale	-2	3	1	OD2606251020209742	Trừ kho khi tạo đơn OD2606251020209742	2026-06-25 10:20:20.516646
\.


--
-- TOC entry 5558 (class 0 OID 26154)
-- Dependencies: 312
-- Data for Name: storebranches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.storebranches (branchid, branchname, address, phone, openhours, mapurl, isactive, createdat) FROM stdin;
1	PhoneShop Hà Nội	Số 1 Cầu Giấy, Hà Nội	0123456789	08:00 - 21:00	\N	t	2026-06-26 00:21:18.747823
2	PhoneShop TP.HCM	Số 1 Nguyễn Huệ, Quận 1, TP.HCM	0987654321	08:00 - 21:00	\N	t	2026-06-26 00:21:18.747823
\.


--
-- TOC entry 5533 (class 0 OID 25874)
-- Dependencies: 287
-- Data for Name: supporttickets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.supporttickets (ticketid, userid, fullname, email, phone, subject, message, status, adminreply, repliedat, createdat, updatedat) FROM stdin;
\.


--
-- TOC entry 5541 (class 0 OID 25974)
-- Dependencies: 295
-- Data for Name: tradeinrequests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tradeinrequests (requestid, userid, targetproductid, olddevicebrand, olddevicemodel, imei, conditionlevel, customerdescription, estimatedvalue, status, adminnote, createdat, updatedat) FROM stdin;
\.


--
-- TOC entry 5497 (class 0 OID 25391)
-- Dependencies: 251
-- Data for Name: useraddresses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.useraddresses (addressid, userid, receivername, phone, address, isdefault) FROM stdin;
1	db3c1386-fe73-4f74-9a67-1aac5374a0b9	Nguy?n Van A	0911111111	TP H? Ch¡ Minh	t
2	5fd37367-b63b-4b7f-87ef-5c0402f48b20	Tr?n Th? B	0922222222	D… N?ng	t
3	f0873800-51c7-4254-ab65-08808e168cff	System Admin	0000000000	PhoneShop HQ	t
4	65fde457-3a4f-41da-a63f-1bf14ba153a4	tuducduy	0374705913	Hà nội	t
5	ff0aa178-b8ac-49a4-8715-d755a3495d24	Admin Website	0900000000	Hà Nội	t
6	6742622f-8161-4167-bec7-6ee53d86ef07	Nguyễn Văn A	0374705913	Minh Khai	t
\.


--
-- TOC entry 5499 (class 0 OID 25398)
-- Dependencies: 253
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (userid, fullname, email, passwordhash, phone, address, roleid, isactive, createdat, updatedat, lastloginat, lockedreason, avatarurl) FROM stdin;
db3c1386-fe73-4f74-9a67-1aac5374a0b9	Nguyễn Văn An	user1@gmail.com	123456	0911111111	TP Hồ Chí Minh	2	t	2026-02-10 15:54:34.342524	\N	\N	\N	\N
5fd37367-b63b-4b7f-87ef-5c0402f48b20	Trần Thị Bình	user2@gmail.com	123456	0922222222	Đà Năng	2	t	2026-02-10 15:54:34.342524	\N	\N	\N	\N
f0873800-51c7-4254-ab65-08808e168cff	System Admin	admin@phoneshop.local	AQAAAAIAAYagAAAAEMCCFnrL2jpy8v8YNFpxg5VrwZJ7fXCdWc97xbvvlKzNw3g36EsaArfs6Ekwa49qqw==	0000000000	PhoneShop HQ	1	t	2026-06-19 11:58:09.265589	\N	\N	\N	\N
65fde457-3a4f-41da-a63f-1bf14ba153a4	tuducduy	tuducduy@gmail.com	AQAAAAIAAYagAAAAEIv44OWHHl0WtsRwXya5gHxkBzQVHKIH7uD4Kq8ft8znkh7Y6FjogW36vFMyVitomw==	0374705913	Hà nội	3	t	2026-06-22 00:14:04.118747	\N	\N	\N	\N
6742622f-8161-4167-bec7-6ee53d86ef07	Nguyễn Văn A	tuducduybg@gmail.com	AQAAAAIAAYagAAAAEBNePBwaMgTsQJf71g7rRqk6p1/TwCN9O6h0NxH7G3vZgY8+7wXzsnRZIk7J2FLTmA==	0374705913	Minh Khai	3	t	2026-06-22 11:44:32.378842	\N	\N	\N	\N
ff0aa178-b8ac-49a4-8715-d755a3495d24	Admin Website	admin@gmail.com	AQAAAAIAAYagAAAAEIv44OWHHl0WtsRwXya5gHxkBzQVHKIH7uD4Kq8ft8znkh7Y6FjogW36vFMyVitomw==	0900000000	Hà Nội	1	t	2026-02-10 15:54:24.508669	\N	2026-07-19 22:04:19.45809	\N	\N
\.


--
-- TOC entry 5500 (class 0 OID 25406)
-- Dependencies: 254
-- Data for Name: vouchers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vouchers (voucherid, code, discountpercent, maxdiscount, expiredat, quantity) FROM stdin;
1	SALE10	10	500000.00	2026-08-25 00:40:37.530141	200
2	PHONE5	5	300000.00	2026-09-24 00:40:37.530141	300
\.


--
-- TOC entry 5535 (class 0 OID 25891)
-- Dependencies: 289
-- Data for Name: warrantyrequests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.warrantyrequests (warrantyrequestid, userid, orderid, productid, requesttype, status, reason, customerimageurl, adminnote, createdat, updatedat) FROM stdin;
\.


--
-- TOC entry 5503 (class 0 OID 25597)
-- Dependencies: 257
-- Data for Name: wishlistitems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wishlistitems (wishlistitemid, userid, productid, createdat) FROM stdin;
\.


--
-- TOC entry 5614 (class 0 OID 0)
-- Dependencies: 282
-- Name: adminactivitylogs_activityid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.adminactivitylogs_activityid_seq', 1, false);


--
-- TOC entry 5615 (class 0 OID 0)
-- Dependencies: 219
-- Name: auditlogs_logid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auditlogs_logid_seq', 1, false);


--
-- TOC entry 5616 (class 0 OID 0)
-- Dependencies: 221
-- Name: brands_brandid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.brands_brandid_seq', 12, true);


--
-- TOC entry 5617 (class 0 OID 0)
-- Dependencies: 223
-- Name: cartitems_cartitemid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cartitems_cartitemid_seq', 8, true);


--
-- TOC entry 5618 (class 0 OID 0)
-- Dependencies: 225
-- Name: carts_cartid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.carts_cartid_seq', 3, true);


--
-- TOC entry 5619 (class 0 OID 0)
-- Dependencies: 227
-- Name: categories_categoryid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_categoryid_seq', 18, true);


--
-- TOC entry 5620 (class 0 OID 0)
-- Dependencies: 229
-- Name: chatconversations_conversationid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.chatconversations_conversationid_seq', 3, true);


--
-- TOC entry 5621 (class 0 OID 0)
-- Dependencies: 231
-- Name: chatmessages_messageid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.chatmessages_messageid_seq', 4, true);


--
-- TOC entry 5622 (class 0 OID 0)
-- Dependencies: 272
-- Name: contentcategories_categoryid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contentcategories_categoryid_seq', 3, true);


--
-- TOC entry 5623 (class 0 OID 0)
-- Dependencies: 280
-- Name: customerbehaviors_behaviorid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customerbehaviors_behaviorid_seq', 1, false);


--
-- TOC entry 5624 (class 0 OID 0)
-- Dependencies: 276
-- Name: faqitems_faqid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faqitems_faqid_seq', 4, true);


--
-- TOC entry 5625 (class 0 OID 0)
-- Dependencies: 284
-- Name: homepagebanners_bannerid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.homepagebanners_bannerid_seq', 5, true);


--
-- TOC entry 5626 (class 0 OID 0)
-- Dependencies: 290
-- Name: installmentplans_planid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.installmentplans_planid_seq', 3, true);


--
-- TOC entry 5627 (class 0 OID 0)
-- Dependencies: 292
-- Name: installmentrequests_requestid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.installmentrequests_requestid_seq', 1, false);


--
-- TOC entry 5628 (class 0 OID 0)
-- Dependencies: 298
-- Name: loyaltypointtransactions_transactionid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.loyaltypointtransactions_transactionid_seq', 5, true);


--
-- TOC entry 5629 (class 0 OID 0)
-- Dependencies: 278
-- Name: marketingcampaigns_campaignid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.marketingcampaigns_campaignid_seq', 1, true);


--
-- TOC entry 5630 (class 0 OID 0)
-- Dependencies: 274
-- Name: newsarticles_articleid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.newsarticles_articleid_seq', 2, true);


--
-- TOC entry 5631 (class 0 OID 0)
-- Dependencies: 301
-- Name: newslettersubscribers_subscriberid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.newslettersubscribers_subscriberid_seq', 1, false);


--
-- TOC entry 5632 (class 0 OID 0)
-- Dependencies: 266
-- Name: notifications_notificationid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_notificationid_seq', 2, true);


--
-- TOC entry 5633 (class 0 OID 0)
-- Dependencies: 233
-- Name: orderdetails_orderdetailid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orderdetails_orderdetailid_seq', 6, true);


--
-- TOC entry 5634 (class 0 OID 0)
-- Dependencies: 235
-- Name: orders_orderid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_orderid_seq', 6, true);


--
-- TOC entry 5635 (class 0 OID 0)
-- Dependencies: 305
-- Name: ordershipments_shipmentid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ordershipments_shipmentid_seq', 1, false);


--
-- TOC entry 5636 (class 0 OID 0)
-- Dependencies: 237
-- Name: orderstatus_statusid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orderstatus_statusid_seq', 1, false);


--
-- TOC entry 5637 (class 0 OID 0)
-- Dependencies: 239
-- Name: orderstatushistory_historyid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orderstatushistory_historyid_seq', 7, true);


--
-- TOC entry 5638 (class 0 OID 0)
-- Dependencies: 307
-- Name: paymenttransactions_transactionid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.paymenttransactions_transactionid_seq', 6, true);


--
-- TOC entry 5639 (class 0 OID 0)
-- Dependencies: 313
-- Name: pickupappointments_appointmentid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pickupappointments_appointmentid_seq', 1, false);


--
-- TOC entry 5640 (class 0 OID 0)
-- Dependencies: 270
-- Name: productbundleitems_bundleitemid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productbundleitems_bundleitemid_seq', 2, true);


--
-- TOC entry 5641 (class 0 OID 0)
-- Dependencies: 268
-- Name: productbundles_bundleid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productbundles_bundleid_seq', 1, true);


--
-- TOC entry 5642 (class 0 OID 0)
-- Dependencies: 241
-- Name: productimages_imageid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productimages_imageid_seq', 4, true);


--
-- TOC entry 5643 (class 0 OID 0)
-- Dependencies: 296
-- Name: productpricealerts_alertid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productpricealerts_alertid_seq', 1, false);


--
-- TOC entry 5644 (class 0 OID 0)
-- Dependencies: 264
-- Name: productpromotions_promotionid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productpromotions_promotionid_seq', 32, true);


--
-- TOC entry 5645 (class 0 OID 0)
-- Dependencies: 258
-- Name: productquestions_questionid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productquestions_questionid_seq', 9, true);


--
-- TOC entry 5646 (class 0 OID 0)
-- Dependencies: 243
-- Name: products_productid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_productid_seq', 31, true);


--
-- TOC entry 5647 (class 0 OID 0)
-- Dependencies: 260
-- Name: productviews_viewid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productviews_viewid_seq', 2, true);


--
-- TOC entry 5648 (class 0 OID 0)
-- Dependencies: 309
-- Name: refundrequests_refundid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.refundrequests_refundid_seq', 1, false);


--
-- TOC entry 5649 (class 0 OID 0)
-- Dependencies: 246
-- Name: reviews_reviewid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reviews_reviewid_seq', 2, true);


--
-- TOC entry 5650 (class 0 OID 0)
-- Dependencies: 248
-- Name: roles_roleid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_roleid_seq', 3, true);


--
-- TOC entry 5651 (class 0 OID 0)
-- Dependencies: 303
-- Name: shippingproviders_providerid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shippingproviders_providerid_seq', 3, true);


--
-- TOC entry 5652 (class 0 OID 0)
-- Dependencies: 250
-- Name: specifications_specid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.specifications_specid_seq', 30, true);


--
-- TOC entry 5653 (class 0 OID 0)
-- Dependencies: 262
-- Name: stockmovements_movementid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stockmovements_movementid_seq', 1, true);


--
-- TOC entry 5654 (class 0 OID 0)
-- Dependencies: 311
-- Name: storebranches_branchid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.storebranches_branchid_seq', 2, true);


--
-- TOC entry 5655 (class 0 OID 0)
-- Dependencies: 286
-- Name: supporttickets_ticketid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.supporttickets_ticketid_seq', 1, false);


--
-- TOC entry 5656 (class 0 OID 0)
-- Dependencies: 294
-- Name: tradeinrequests_requestid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tradeinrequests_requestid_seq', 1, false);


--
-- TOC entry 5657 (class 0 OID 0)
-- Dependencies: 252
-- Name: useraddresses_addressid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.useraddresses_addressid_seq', 6, true);


--
-- TOC entry 5658 (class 0 OID 0)
-- Dependencies: 255
-- Name: vouchers_voucherid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vouchers_voucherid_seq', 6, true);


--
-- TOC entry 5659 (class 0 OID 0)
-- Dependencies: 288
-- Name: warrantyrequests_warrantyrequestid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.warrantyrequests_warrantyrequestid_seq', 1, false);


--
-- TOC entry 5660 (class 0 OID 0)
-- Dependencies: 256
-- Name: wishlistitems_wishlistitemid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wishlistitems_wishlistitemid_seq', 1, true);


--
-- TOC entry 5197 (class 2606 OID 25852)
-- Name: adminactivitylogs adminactivitylogs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adminactivitylogs
    ADD CONSTRAINT adminactivitylogs_pkey PRIMARY KEY (activityid);


--
-- TOC entry 5077 (class 2606 OID 25429)
-- Name: auditlogs auditlogs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auditlogs
    ADD CONSTRAINT auditlogs_pkey PRIMARY KEY (logid);


--
-- TOC entry 5079 (class 2606 OID 25431)
-- Name: brands brands_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT brands_pkey PRIMARY KEY (brandid);


--
-- TOC entry 5081 (class 2606 OID 25433)
-- Name: cartitems cartitems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartitems
    ADD CONSTRAINT cartitems_pkey PRIMARY KEY (cartitemid);


--
-- TOC entry 5083 (class 2606 OID 25435)
-- Name: carts carts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (cartid);


--
-- TOC entry 5085 (class 2606 OID 25437)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (categoryid);


--
-- TOC entry 5087 (class 2606 OID 25439)
-- Name: chatconversations chatconversations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chatconversations
    ADD CONSTRAINT chatconversations_pkey PRIMARY KEY (conversationid);


--
-- TOC entry 5091 (class 2606 OID 25441)
-- Name: chatmessages chatmessages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chatmessages
    ADD CONSTRAINT chatmessages_pkey PRIMARY KEY (messageid);


--
-- TOC entry 5178 (class 2606 OID 25777)
-- Name: contentcategories contentcategories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contentcategories
    ADD CONSTRAINT contentcategories_pkey PRIMARY KEY (categoryid);


--
-- TOC entry 5192 (class 2606 OID 25834)
-- Name: customerbehaviors customerbehaviors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customerbehaviors
    ADD CONSTRAINT customerbehaviors_pkey PRIMARY KEY (behaviorid);


--
-- TOC entry 5186 (class 2606 OID 25811)
-- Name: faqitems faqitems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faqitems
    ADD CONSTRAINT faqitems_pkey PRIMARY KEY (faqid);


--
-- TOC entry 5201 (class 2606 OID 25872)
-- Name: homepagebanners homepagebanners_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.homepagebanners
    ADD CONSTRAINT homepagebanners_pkey PRIMARY KEY (bannerid);


--
-- TOC entry 5213 (class 2606 OID 25936)
-- Name: installmentplans installmentplans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.installmentplans
    ADD CONSTRAINT installmentplans_pkey PRIMARY KEY (planid);


--
-- TOC entry 5218 (class 2606 OID 25955)
-- Name: installmentrequests installmentrequests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.installmentrequests
    ADD CONSTRAINT installmentrequests_pkey PRIMARY KEY (requestid);


--
-- TOC entry 5228 (class 2606 OID 26028)
-- Name: loyaltypointtransactions loyaltypointtransactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loyaltypointtransactions
    ADD CONSTRAINT loyaltypointtransactions_pkey PRIMARY KEY (transactionid);


--
-- TOC entry 5190 (class 2606 OID 25823)
-- Name: marketingcampaigns marketingcampaigns_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marketingcampaigns
    ADD CONSTRAINT marketingcampaigns_pkey PRIMARY KEY (campaignid);


--
-- TOC entry 5183 (class 2606 OID 25791)
-- Name: newsarticles newsarticles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.newsarticles
    ADD CONSTRAINT newsarticles_pkey PRIMARY KEY (articleid);


--
-- TOC entry 5234 (class 2606 OID 26059)
-- Name: newslettersubscribers newslettersubscribers_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.newslettersubscribers
    ADD CONSTRAINT newslettersubscribers_email_key UNIQUE (email);


--
-- TOC entry 5236 (class 2606 OID 26057)
-- Name: newslettersubscribers newslettersubscribers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.newslettersubscribers
    ADD CONSTRAINT newslettersubscribers_pkey PRIMARY KEY (subscriberid);


--
-- TOC entry 5168 (class 2606 OID 25720)
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (notificationid);


--
-- TOC entry 5095 (class 2606 OID 25443)
-- Name: orderdetails orderdetails_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderdetails
    ADD CONSTRAINT orderdetails_pkey PRIMARY KEY (orderdetailid);


--
-- TOC entry 5097 (class 2606 OID 26196)
-- Name: orders orders_ordercode_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_ordercode_key UNIQUE (ordercode);


--
-- TOC entry 5099 (class 2606 OID 25447)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (orderid);


--
-- TOC entry 5243 (class 2606 OID 26084)
-- Name: ordershipments ordershipments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordershipments
    ADD CONSTRAINT ordershipments_pkey PRIMARY KEY (shipmentid);


--
-- TOC entry 5101 (class 2606 OID 25449)
-- Name: orderstatus orderstatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderstatus
    ADD CONSTRAINT orderstatus_pkey PRIMARY KEY (statusid);


--
-- TOC entry 5104 (class 2606 OID 25451)
-- Name: orderstatushistory orderstatushistory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderstatushistory
    ADD CONSTRAINT orderstatushistory_pkey PRIMARY KEY (historyid);


--
-- TOC entry 5247 (class 2606 OID 26109)
-- Name: paymenttransactions paymenttransactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paymenttransactions
    ADD CONSTRAINT paymenttransactions_pkey PRIMARY KEY (transactionid);


--
-- TOC entry 5258 (class 2606 OID 26175)
-- Name: pickupappointments pickupappointments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickupappointments
    ADD CONSTRAINT pickupappointments_pkey PRIMARY KEY (appointmentid);


--
-- TOC entry 5175 (class 2606 OID 25753)
-- Name: productbundleitems productbundleitems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productbundleitems
    ADD CONSTRAINT productbundleitems_pkey PRIMARY KEY (bundleitemid);


--
-- TOC entry 5171 (class 2606 OID 25743)
-- Name: productbundles productbundles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productbundles
    ADD CONSTRAINT productbundles_pkey PRIMARY KEY (bundleid);


--
-- TOC entry 5107 (class 2606 OID 25453)
-- Name: productimages productimages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productimages
    ADD CONSTRAINT productimages_pkey PRIMARY KEY (imageid);


--
-- TOC entry 5225 (class 2606 OID 26007)
-- Name: productpricealerts productpricealerts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productpricealerts
    ADD CONSTRAINT productpricealerts_pkey PRIMARY KEY (alertid);


--
-- TOC entry 5164 (class 2606 OID 25701)
-- Name: productpromotions productpromotions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productpromotions
    ADD CONSTRAINT productpromotions_pkey PRIMARY KEY (promotionid);


--
-- TOC entry 5150 (class 2606 OID 25628)
-- Name: productquestions productquestions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productquestions
    ADD CONSTRAINT productquestions_pkey PRIMARY KEY (questionid);


--
-- TOC entry 5110 (class 2606 OID 25455)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (productid);


--
-- TOC entry 5113 (class 2606 OID 25457)
-- Name: productspecifications productspecifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productspecifications
    ADD CONSTRAINT productspecifications_pkey PRIMARY KEY (productid, specid);


--
-- TOC entry 5155 (class 2606 OID 25654)
-- Name: productviews productviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productviews
    ADD CONSTRAINT productviews_pkey PRIMARY KEY (viewid);


--
-- TOC entry 5252 (class 2606 OID 26135)
-- Name: refundrequests refundrequests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refundrequests
    ADD CONSTRAINT refundrequests_pkey PRIMARY KEY (refundid);


--
-- TOC entry 5116 (class 2606 OID 25459)
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (reviewid);


--
-- TOC entry 5119 (class 2606 OID 25461)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (roleid);


--
-- TOC entry 5121 (class 2606 OID 25463)
-- Name: roles roles_rolename_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_rolename_key UNIQUE (rolename);


--
-- TOC entry 5238 (class 2606 OID 26071)
-- Name: shippingproviders shippingproviders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shippingproviders
    ADD CONSTRAINT shippingproviders_pkey PRIMARY KEY (providerid);


--
-- TOC entry 5231 (class 2606 OID 26048)
-- Name: siteconfigs siteconfigs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.siteconfigs
    ADD CONSTRAINT siteconfigs_pkey PRIMARY KEY (configkey);


--
-- TOC entry 5123 (class 2606 OID 25465)
-- Name: specifications specifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specifications
    ADD CONSTRAINT specifications_pkey PRIMARY KEY (specid);


--
-- TOC entry 5160 (class 2606 OID 25678)
-- Name: stockmovements stockmovements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stockmovements
    ADD CONSTRAINT stockmovements_pkey PRIMARY KEY (movementid);


--
-- TOC entry 5254 (class 2606 OID 26163)
-- Name: storebranches storebranches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.storebranches
    ADD CONSTRAINT storebranches_pkey PRIMARY KEY (branchid);


--
-- TOC entry 5206 (class 2606 OID 25884)
-- Name: supporttickets supporttickets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supporttickets
    ADD CONSTRAINT supporttickets_pkey PRIMARY KEY (ticketid);


--
-- TOC entry 5222 (class 2606 OID 25985)
-- Name: tradeinrequests tradeinrequests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tradeinrequests
    ADD CONSTRAINT tradeinrequests_pkey PRIMARY KEY (requestid);


--
-- TOC entry 5126 (class 2606 OID 25467)
-- Name: useraddresses useraddresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.useraddresses
    ADD CONSTRAINT useraddresses_pkey PRIMARY KEY (addressid);


--
-- TOC entry 5133 (class 2606 OID 25469)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 5135 (class 2606 OID 25471)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (userid);


--
-- TOC entry 5137 (class 2606 OID 25473)
-- Name: vouchers vouchers_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vouchers
    ADD CONSTRAINT vouchers_code_key UNIQUE (code);


--
-- TOC entry 5139 (class 2606 OID 25475)
-- Name: vouchers vouchers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vouchers
    ADD CONSTRAINT vouchers_pkey PRIMARY KEY (voucherid);


--
-- TOC entry 5211 (class 2606 OID 25902)
-- Name: warrantyrequests warrantyrequests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warrantyrequests
    ADD CONSTRAINT warrantyrequests_pkey PRIMARY KEY (warrantyrequestid);


--
-- TOC entry 5143 (class 2606 OID 25603)
-- Name: wishlistitems wishlistitems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wishlistitems
    ADD CONSTRAINT wishlistitems_pkey PRIMARY KEY (wishlistitemid);


--
-- TOC entry 5145 (class 2606 OID 25605)
-- Name: wishlistitems wishlistitems_userid_productid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wishlistitems
    ADD CONSTRAINT wishlistitems_userid_productid_key UNIQUE (userid, productid);


--
-- TOC entry 5179 (class 1259 OID 25778)
-- Name: contentcategories_slug_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX contentcategories_slug_key ON public.contentcategories USING btree (slug);


--
-- TOC entry 5198 (class 1259 OID 25858)
-- Name: idx_adminactivitylogs_createdat; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_adminactivitylogs_createdat ON public.adminactivitylogs USING btree (createdat DESC);


--
-- TOC entry 5199 (class 1259 OID 25859)
-- Name: idx_adminactivitylogs_userid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_adminactivitylogs_userid ON public.adminactivitylogs USING btree (userid);


--
-- TOC entry 5088 (class 1259 OID 25476)
-- Name: idx_chatconversations_updatedat; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_chatconversations_updatedat ON public.chatconversations USING btree (updatedat DESC);


--
-- TOC entry 5089 (class 1259 OID 25477)
-- Name: idx_chatconversations_userid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_chatconversations_userid ON public.chatconversations USING btree (userid);


--
-- TOC entry 5092 (class 1259 OID 25478)
-- Name: idx_chatmessages_conversationid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_chatmessages_conversationid ON public.chatmessages USING btree (conversationid);


--
-- TOC entry 5093 (class 1259 OID 25479)
-- Name: idx_chatmessages_senderid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_chatmessages_senderid ON public.chatmessages USING btree (senderid);


--
-- TOC entry 5193 (class 1259 OID 25840)
-- Name: idx_customerbehaviors_event_created; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_customerbehaviors_event_created ON public.customerbehaviors USING btree (eventtype, createdat DESC);


--
-- TOC entry 5194 (class 1259 OID 25842)
-- Name: idx_customerbehaviors_sessionid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_customerbehaviors_sessionid ON public.customerbehaviors USING btree (sessionid);


--
-- TOC entry 5195 (class 1259 OID 25841)
-- Name: idx_customerbehaviors_userid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_customerbehaviors_userid ON public.customerbehaviors USING btree (userid);


--
-- TOC entry 5187 (class 1259 OID 25812)
-- Name: idx_faqitems_active_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_faqitems_active_group ON public.faqitems USING btree (isactive, groupname);


--
-- TOC entry 5202 (class 1259 OID 25918)
-- Name: idx_homepagebanners_active_order; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_homepagebanners_active_order ON public.homepagebanners USING btree (isactive, displayorder);


--
-- TOC entry 5215 (class 1259 OID 25972)
-- Name: idx_installmentrequests_status_created; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_installmentrequests_status_created ON public.installmentrequests USING btree (status, createdat DESC);


--
-- TOC entry 5216 (class 1259 OID 25971)
-- Name: idx_installmentrequests_user_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_installmentrequests_user_status ON public.installmentrequests USING btree (userid, status);


--
-- TOC entry 5226 (class 1259 OID 26039)
-- Name: idx_loyaltypoints_user_created; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_loyaltypoints_user_created ON public.loyaltypointtransactions USING btree (userid, createdat DESC);


--
-- TOC entry 5188 (class 1259 OID 25824)
-- Name: idx_marketingcampaigns_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_marketingcampaigns_status ON public.marketingcampaigns USING btree (status);


--
-- TOC entry 5180 (class 1259 OID 25799)
-- Name: idx_newsarticles_categoryid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_newsarticles_categoryid ON public.newsarticles USING btree (categoryid);


--
-- TOC entry 5181 (class 1259 OID 25798)
-- Name: idx_newsarticles_published; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_newsarticles_published ON public.newsarticles USING btree (ispublished, publishedat DESC);


--
-- TOC entry 5232 (class 1259 OID 26060)
-- Name: idx_newslettersubscribers_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_newslettersubscribers_active ON public.newslettersubscribers USING btree (isactive);


--
-- TOC entry 5165 (class 1259 OID 25727)
-- Name: idx_notifications_createdat; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_notifications_createdat ON public.notifications USING btree (createdat DESC);


--
-- TOC entry 5166 (class 1259 OID 25726)
-- Name: idx_notifications_user_read; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_notifications_user_read ON public.notifications USING btree (userid, isread);


--
-- TOC entry 5239 (class 1259 OID 26097)
-- Name: idx_ordershipments_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ordershipments_status ON public.ordershipments USING btree (status);


--
-- TOC entry 5240 (class 1259 OID 26096)
-- Name: idx_ordershipments_trackingnumber; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ordershipments_trackingnumber ON public.ordershipments USING btree (trackingnumber);


--
-- TOC entry 5244 (class 1259 OID 26121)
-- Name: idx_paymenttransactions_orderid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_paymenttransactions_orderid ON public.paymenttransactions USING btree (orderid);


--
-- TOC entry 5245 (class 1259 OID 26122)
-- Name: idx_paymenttransactions_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_paymenttransactions_status ON public.paymenttransactions USING btree (status);


--
-- TOC entry 5255 (class 1259 OID 26192)
-- Name: idx_pickupappointments_branch_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_pickupappointments_branch_date ON public.pickupappointments USING btree (branchid, appointmentdate);


--
-- TOC entry 5256 (class 1259 OID 26191)
-- Name: idx_pickupappointments_user_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_pickupappointments_user_status ON public.pickupappointments USING btree (userid, status);


--
-- TOC entry 5173 (class 1259 OID 25765)
-- Name: idx_productbundleitems_productid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_productbundleitems_productid ON public.productbundleitems USING btree (productid);


--
-- TOC entry 5169 (class 1259 OID 25745)
-- Name: idx_productbundles_active_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_productbundles_active_time ON public.productbundles USING btree (isactive, startat, endat);


--
-- TOC entry 5105 (class 1259 OID 25591)
-- Name: idx_productimages_productid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_productimages_productid ON public.productimages USING btree (productid);


--
-- TOC entry 5223 (class 1259 OID 26018)
-- Name: idx_productpricealerts_user_product_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_productpricealerts_user_product_active ON public.productpricealerts USING btree (userid, productid, isactive);


--
-- TOC entry 5161 (class 1259 OID 25707)
-- Name: idx_productpromotions_product_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_productpromotions_product_active ON public.productpromotions USING btree (productid, isactive);


--
-- TOC entry 5162 (class 1259 OID 25708)
-- Name: idx_productpromotions_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_productpromotions_time ON public.productpromotions USING btree (startat, endat);


--
-- TOC entry 5146 (class 1259 OID 25644)
-- Name: idx_productquestions_productid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_productquestions_productid ON public.productquestions USING btree (productid);


--
-- TOC entry 5147 (class 1259 OID 25645)
-- Name: idx_productquestions_userid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_productquestions_userid ON public.productquestions USING btree (userid);


--
-- TOC entry 5148 (class 1259 OID 25646)
-- Name: idx_productquestions_visible_answer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_productquestions_visible_answer ON public.productquestions USING btree (isvisible, answeredat);


--
-- TOC entry 5108 (class 1259 OID 25480)
-- Name: idx_products_price; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_products_price ON public.products USING btree (price);


--
-- TOC entry 5111 (class 1259 OID 25593)
-- Name: idx_productspecifications_specid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_productspecifications_specid ON public.productspecifications USING btree (specid);


--
-- TOC entry 5151 (class 1259 OID 25665)
-- Name: idx_productviews_productid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_productviews_productid ON public.productviews USING btree (productid);


--
-- TOC entry 5152 (class 1259 OID 25666)
-- Name: idx_productviews_userid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_productviews_userid ON public.productviews USING btree (userid);


--
-- TOC entry 5153 (class 1259 OID 25667)
-- Name: idx_productviews_viewedat; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_productviews_viewedat ON public.productviews USING btree (viewedat DESC);


--
-- TOC entry 5249 (class 1259 OID 26152)
-- Name: idx_refundrequests_orderid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_refundrequests_orderid ON public.refundrequests USING btree (orderid);


--
-- TOC entry 5250 (class 1259 OID 26151)
-- Name: idx_refundrequests_user_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_refundrequests_user_status ON public.refundrequests USING btree (userid, status);


--
-- TOC entry 5114 (class 1259 OID 25595)
-- Name: idx_reviews_productid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reviews_productid ON public.reviews USING btree (productid);


--
-- TOC entry 5156 (class 1259 OID 25690)
-- Name: idx_stockmovements_createdat; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_stockmovements_createdat ON public.stockmovements USING btree (createdat DESC);


--
-- TOC entry 5157 (class 1259 OID 25689)
-- Name: idx_stockmovements_productid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_stockmovements_productid ON public.stockmovements USING btree (productid);


--
-- TOC entry 5158 (class 1259 OID 25691)
-- Name: idx_stockmovements_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_stockmovements_type ON public.stockmovements USING btree (movementtype);


--
-- TOC entry 5203 (class 1259 OID 25920)
-- Name: idx_supporttickets_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_supporttickets_status ON public.supporttickets USING btree (status);


--
-- TOC entry 5204 (class 1259 OID 25919)
-- Name: idx_supporttickets_userid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_supporttickets_userid ON public.supporttickets USING btree (userid);


--
-- TOC entry 5219 (class 1259 OID 25997)
-- Name: idx_tradeinrequests_status_created; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_tradeinrequests_status_created ON public.tradeinrequests USING btree (status, createdat DESC);


--
-- TOC entry 5220 (class 1259 OID 25996)
-- Name: idx_tradeinrequests_user_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_tradeinrequests_user_status ON public.tradeinrequests USING btree (userid, status);


--
-- TOC entry 5127 (class 1259 OID 26207)
-- Name: idx_users_createdat; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_users_createdat ON public.users USING btree (createdat);


--
-- TOC entry 5128 (class 1259 OID 25481)
-- Name: idx_users_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_users_email ON public.users USING btree (email);


--
-- TOC entry 5129 (class 1259 OID 26204)
-- Name: idx_users_email_lower; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_users_email_lower ON public.users USING btree (lower((email)::text));


--
-- TOC entry 5130 (class 1259 OID 26206)
-- Name: idx_users_isactive; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_users_isactive ON public.users USING btree (isactive);


--
-- TOC entry 5131 (class 1259 OID 26205)
-- Name: idx_users_roleid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_users_roleid ON public.users USING btree (roleid);


--
-- TOC entry 5207 (class 1259 OID 25923)
-- Name: idx_warrantyrequests_orderid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_warrantyrequests_orderid ON public.warrantyrequests USING btree (orderid);


--
-- TOC entry 5208 (class 1259 OID 25922)
-- Name: idx_warrantyrequests_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_warrantyrequests_status ON public.warrantyrequests USING btree (status);


--
-- TOC entry 5209 (class 1259 OID 25921)
-- Name: idx_warrantyrequests_userid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_warrantyrequests_userid ON public.warrantyrequests USING btree (userid);


--
-- TOC entry 5140 (class 1259 OID 25617)
-- Name: idx_wishlistitems_productid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_wishlistitems_productid ON public.wishlistitems USING btree (productid);


--
-- TOC entry 5141 (class 1259 OID 25616)
-- Name: idx_wishlistitems_userid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_wishlistitems_userid ON public.wishlistitems USING btree (userid);


--
-- TOC entry 5184 (class 1259 OID 25797)
-- Name: newsarticles_slug_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX newsarticles_slug_key ON public.newsarticles USING btree (slug);


--
-- TOC entry 5241 (class 1259 OID 26095)
-- Name: ordershipments_orderid_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ordershipments_orderid_key ON public.ordershipments USING btree (orderid);


--
-- TOC entry 5248 (class 1259 OID 26120)
-- Name: paymenttransactions_transactioncode_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX paymenttransactions_transactioncode_key ON public.paymenttransactions USING btree (transactioncode);


--
-- TOC entry 5172 (class 1259 OID 25744)
-- Name: productbundles_slug_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX productbundles_slug_key ON public.productbundles USING btree (slug);


--
-- TOC entry 5117 (class 1259 OID 25594)
-- Name: reviews_user_product_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX reviews_user_product_key ON public.reviews USING btree (userid, productid);


--
-- TOC entry 5124 (class 1259 OID 25592)
-- Name: specifications_specname_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX specifications_specname_key ON public.specifications USING btree (specname);


--
-- TOC entry 5214 (class 1259 OID 25937)
-- Name: ux_installmentplans_planname_term; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ux_installmentplans_planname_term ON public.installmentplans USING btree (planname, termmonths);


--
-- TOC entry 5229 (class 1259 OID 26040)
-- Name: ux_loyaltypoints_order_earn; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ux_loyaltypoints_order_earn ON public.loyaltypointtransactions USING btree (orderid, transactiontype) WHERE ((orderid IS NOT NULL) AND ((transactiontype)::text = 'Earn'::text));


--
-- TOC entry 5102 (class 1259 OID 25728)
-- Name: ux_orderstatus_statusid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ux_orderstatus_statusid ON public.orderstatus USING btree (statusid);


--
-- TOC entry 5176 (class 1259 OID 25764)
-- Name: ux_productbundleitems_bundle_product; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ux_productbundleitems_bundle_product ON public.productbundleitems USING btree (bundleid, productid);


--
-- TOC entry 5295 (class 2606 OID 25853)
-- Name: adminactivitylogs adminactivitylogs_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adminactivitylogs
    ADD CONSTRAINT adminactivitylogs_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE SET NULL;


--
-- TOC entry 5259 (class 2606 OID 25482)
-- Name: cartitems cartitems_cartid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartitems
    ADD CONSTRAINT cartitems_cartid_fkey FOREIGN KEY (cartid) REFERENCES public.carts(cartid) ON DELETE CASCADE;


--
-- TOC entry 5260 (class 2606 OID 25487)
-- Name: cartitems cartitems_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartitems
    ADD CONSTRAINT cartitems_productid_fkey FOREIGN KEY (productid) REFERENCES public.products(productid);


--
-- TOC entry 5261 (class 2606 OID 25492)
-- Name: carts carts_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid);


--
-- TOC entry 5262 (class 2606 OID 25497)
-- Name: chatconversations chatconversations_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chatconversations
    ADD CONSTRAINT chatconversations_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- TOC entry 5263 (class 2606 OID 25502)
-- Name: chatmessages chatmessages_conversationid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chatmessages
    ADD CONSTRAINT chatmessages_conversationid_fkey FOREIGN KEY (conversationid) REFERENCES public.chatconversations(conversationid) ON DELETE CASCADE;


--
-- TOC entry 5264 (class 2606 OID 25507)
-- Name: chatmessages chatmessages_senderid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.chatmessages
    ADD CONSTRAINT chatmessages_senderid_fkey FOREIGN KEY (senderid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- TOC entry 5294 (class 2606 OID 25835)
-- Name: customerbehaviors customerbehaviors_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customerbehaviors
    ADD CONSTRAINT customerbehaviors_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE SET NULL;


--
-- TOC entry 5300 (class 2606 OID 25966)
-- Name: installmentrequests installmentrequests_planid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.installmentrequests
    ADD CONSTRAINT installmentrequests_planid_fkey FOREIGN KEY (planid) REFERENCES public.installmentplans(planid) ON DELETE SET NULL;


--
-- TOC entry 5301 (class 2606 OID 25961)
-- Name: installmentrequests installmentrequests_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.installmentrequests
    ADD CONSTRAINT installmentrequests_productid_fkey FOREIGN KEY (productid) REFERENCES public.products(productid) ON DELETE SET NULL;


--
-- TOC entry 5302 (class 2606 OID 25956)
-- Name: installmentrequests installmentrequests_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.installmentrequests
    ADD CONSTRAINT installmentrequests_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- TOC entry 5307 (class 2606 OID 26034)
-- Name: loyaltypointtransactions loyaltypointtransactions_orderid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loyaltypointtransactions
    ADD CONSTRAINT loyaltypointtransactions_orderid_fkey FOREIGN KEY (orderid) REFERENCES public.orders(orderid) ON DELETE SET NULL;


--
-- TOC entry 5308 (class 2606 OID 26029)
-- Name: loyaltypointtransactions loyaltypointtransactions_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.loyaltypointtransactions
    ADD CONSTRAINT loyaltypointtransactions_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- TOC entry 5293 (class 2606 OID 25792)
-- Name: newsarticles newsarticles_categoryid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.newsarticles
    ADD CONSTRAINT newsarticles_categoryid_fkey FOREIGN KEY (categoryid) REFERENCES public.contentcategories(categoryid) ON DELETE SET NULL;


--
-- TOC entry 5290 (class 2606 OID 25721)
-- Name: notifications notifications_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- TOC entry 5265 (class 2606 OID 25512)
-- Name: orderdetails orderdetails_orderid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderdetails
    ADD CONSTRAINT orderdetails_orderid_fkey FOREIGN KEY (orderid) REFERENCES public.orders(orderid) ON DELETE CASCADE;


--
-- TOC entry 5266 (class 2606 OID 25517)
-- Name: orderdetails orderdetails_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderdetails
    ADD CONSTRAINT orderdetails_productid_fkey FOREIGN KEY (productid) REFERENCES public.products(productid);


--
-- TOC entry 5267 (class 2606 OID 25522)
-- Name: orders orders_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid);


--
-- TOC entry 5268 (class 2606 OID 25527)
-- Name: orders orders_voucherid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_voucherid_fkey FOREIGN KEY (voucherid) REFERENCES public.vouchers(voucherid);


--
-- TOC entry 5309 (class 2606 OID 26085)
-- Name: ordershipments ordershipments_orderid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordershipments
    ADD CONSTRAINT ordershipments_orderid_fkey FOREIGN KEY (orderid) REFERENCES public.orders(orderid) ON DELETE CASCADE;


--
-- TOC entry 5310 (class 2606 OID 26090)
-- Name: ordershipments ordershipments_providerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ordershipments
    ADD CONSTRAINT ordershipments_providerid_fkey FOREIGN KEY (providerid) REFERENCES public.shippingproviders(providerid) ON DELETE SET NULL;


--
-- TOC entry 5269 (class 2606 OID 25532)
-- Name: orderstatushistory orderstatushistory_orderid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderstatushistory
    ADD CONSTRAINT orderstatushistory_orderid_fkey FOREIGN KEY (orderid) REFERENCES public.orders(orderid);


--
-- TOC entry 5270 (class 2606 OID 25537)
-- Name: orderstatushistory orderstatushistory_statusid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderstatushistory
    ADD CONSTRAINT orderstatushistory_statusid_fkey FOREIGN KEY (statusid) REFERENCES public.orderstatus(statusid);


--
-- TOC entry 5311 (class 2606 OID 26110)
-- Name: paymenttransactions paymenttransactions_orderid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paymenttransactions
    ADD CONSTRAINT paymenttransactions_orderid_fkey FOREIGN KEY (orderid) REFERENCES public.orders(orderid) ON DELETE SET NULL;


--
-- TOC entry 5312 (class 2606 OID 26115)
-- Name: paymenttransactions paymenttransactions_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.paymenttransactions
    ADD CONSTRAINT paymenttransactions_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE SET NULL;


--
-- TOC entry 5316 (class 2606 OID 26186)
-- Name: pickupappointments pickupappointments_branchid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickupappointments
    ADD CONSTRAINT pickupappointments_branchid_fkey FOREIGN KEY (branchid) REFERENCES public.storebranches(branchid) ON DELETE SET NULL;


--
-- TOC entry 5317 (class 2606 OID 26181)
-- Name: pickupappointments pickupappointments_orderid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickupappointments
    ADD CONSTRAINT pickupappointments_orderid_fkey FOREIGN KEY (orderid) REFERENCES public.orders(orderid) ON DELETE SET NULL;


--
-- TOC entry 5318 (class 2606 OID 26176)
-- Name: pickupappointments pickupappointments_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pickupappointments
    ADD CONSTRAINT pickupappointments_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- TOC entry 5291 (class 2606 OID 25754)
-- Name: productbundleitems productbundleitems_bundleid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productbundleitems
    ADD CONSTRAINT productbundleitems_bundleid_fkey FOREIGN KEY (bundleid) REFERENCES public.productbundles(bundleid) ON DELETE CASCADE;


--
-- TOC entry 5292 (class 2606 OID 25759)
-- Name: productbundleitems productbundleitems_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productbundleitems
    ADD CONSTRAINT productbundleitems_productid_fkey FOREIGN KEY (productid) REFERENCES public.products(productid) ON DELETE CASCADE;


--
-- TOC entry 5271 (class 2606 OID 25542)
-- Name: productimages productimages_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productimages
    ADD CONSTRAINT productimages_productid_fkey FOREIGN KEY (productid) REFERENCES public.products(productid) ON DELETE CASCADE;


--
-- TOC entry 5305 (class 2606 OID 26013)
-- Name: productpricealerts productpricealerts_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productpricealerts
    ADD CONSTRAINT productpricealerts_productid_fkey FOREIGN KEY (productid) REFERENCES public.products(productid) ON DELETE CASCADE;


--
-- TOC entry 5306 (class 2606 OID 26008)
-- Name: productpricealerts productpricealerts_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productpricealerts
    ADD CONSTRAINT productpricealerts_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- TOC entry 5289 (class 2606 OID 25702)
-- Name: productpromotions productpromotions_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productpromotions
    ADD CONSTRAINT productpromotions_productid_fkey FOREIGN KEY (productid) REFERENCES public.products(productid) ON DELETE CASCADE;


--
-- TOC entry 5282 (class 2606 OID 25639)
-- Name: productquestions productquestions_answeredbyuserid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productquestions
    ADD CONSTRAINT productquestions_answeredbyuserid_fkey FOREIGN KEY (answeredbyuserid) REFERENCES public.users(userid) ON DELETE SET NULL;


--
-- TOC entry 5283 (class 2606 OID 25629)
-- Name: productquestions productquestions_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productquestions
    ADD CONSTRAINT productquestions_productid_fkey FOREIGN KEY (productid) REFERENCES public.products(productid) ON DELETE CASCADE;


--
-- TOC entry 5284 (class 2606 OID 25634)
-- Name: productquestions productquestions_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productquestions
    ADD CONSTRAINT productquestions_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- TOC entry 5272 (class 2606 OID 25547)
-- Name: products products_brandid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_brandid_fkey FOREIGN KEY (brandid) REFERENCES public.brands(brandid);


--
-- TOC entry 5273 (class 2606 OID 25552)
-- Name: products products_categoryid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_categoryid_fkey FOREIGN KEY (categoryid) REFERENCES public.categories(categoryid);


--
-- TOC entry 5274 (class 2606 OID 25557)
-- Name: productspecifications productspecifications_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productspecifications
    ADD CONSTRAINT productspecifications_productid_fkey FOREIGN KEY (productid) REFERENCES public.products(productid) ON DELETE CASCADE;


--
-- TOC entry 5275 (class 2606 OID 25562)
-- Name: productspecifications productspecifications_specid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productspecifications
    ADD CONSTRAINT productspecifications_specid_fkey FOREIGN KEY (specid) REFERENCES public.specifications(specid);


--
-- TOC entry 5285 (class 2606 OID 25655)
-- Name: productviews productviews_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productviews
    ADD CONSTRAINT productviews_productid_fkey FOREIGN KEY (productid) REFERENCES public.products(productid) ON DELETE CASCADE;


--
-- TOC entry 5286 (class 2606 OID 25660)
-- Name: productviews productviews_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productviews
    ADD CONSTRAINT productviews_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE SET NULL;


--
-- TOC entry 5313 (class 2606 OID 26136)
-- Name: refundrequests refundrequests_orderid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refundrequests
    ADD CONSTRAINT refundrequests_orderid_fkey FOREIGN KEY (orderid) REFERENCES public.orders(orderid) ON DELETE CASCADE;


--
-- TOC entry 5314 (class 2606 OID 26146)
-- Name: refundrequests refundrequests_paymenttransactionid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refundrequests
    ADD CONSTRAINT refundrequests_paymenttransactionid_fkey FOREIGN KEY (paymenttransactionid) REFERENCES public.paymenttransactions(transactionid) ON DELETE SET NULL;


--
-- TOC entry 5315 (class 2606 OID 26141)
-- Name: refundrequests refundrequests_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refundrequests
    ADD CONSTRAINT refundrequests_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- TOC entry 5276 (class 2606 OID 25567)
-- Name: reviews reviews_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_productid_fkey FOREIGN KEY (productid) REFERENCES public.products(productid);


--
-- TOC entry 5277 (class 2606 OID 25572)
-- Name: reviews reviews_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid);


--
-- TOC entry 5287 (class 2606 OID 25679)
-- Name: stockmovements stockmovements_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stockmovements
    ADD CONSTRAINT stockmovements_productid_fkey FOREIGN KEY (productid) REFERENCES public.products(productid) ON DELETE CASCADE;


--
-- TOC entry 5288 (class 2606 OID 25684)
-- Name: stockmovements stockmovements_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stockmovements
    ADD CONSTRAINT stockmovements_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE SET NULL;


--
-- TOC entry 5296 (class 2606 OID 25885)
-- Name: supporttickets supporttickets_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supporttickets
    ADD CONSTRAINT supporttickets_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE SET NULL;


--
-- TOC entry 5303 (class 2606 OID 25991)
-- Name: tradeinrequests tradeinrequests_targetproductid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tradeinrequests
    ADD CONSTRAINT tradeinrequests_targetproductid_fkey FOREIGN KEY (targetproductid) REFERENCES public.products(productid) ON DELETE SET NULL;


--
-- TOC entry 5304 (class 2606 OID 25986)
-- Name: tradeinrequests tradeinrequests_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tradeinrequests
    ADD CONSTRAINT tradeinrequests_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- TOC entry 5278 (class 2606 OID 25577)
-- Name: useraddresses useraddresses_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.useraddresses
    ADD CONSTRAINT useraddresses_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid);


--
-- TOC entry 5279 (class 2606 OID 25582)
-- Name: users users_roleid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_roleid_fkey FOREIGN KEY (roleid) REFERENCES public.roles(roleid);


--
-- TOC entry 5297 (class 2606 OID 25908)
-- Name: warrantyrequests warrantyrequests_orderid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warrantyrequests
    ADD CONSTRAINT warrantyrequests_orderid_fkey FOREIGN KEY (orderid) REFERENCES public.orders(orderid) ON DELETE SET NULL;


--
-- TOC entry 5298 (class 2606 OID 25913)
-- Name: warrantyrequests warrantyrequests_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warrantyrequests
    ADD CONSTRAINT warrantyrequests_productid_fkey FOREIGN KEY (productid) REFERENCES public.products(productid) ON DELETE SET NULL;


--
-- TOC entry 5299 (class 2606 OID 25903)
-- Name: warrantyrequests warrantyrequests_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.warrantyrequests
    ADD CONSTRAINT warrantyrequests_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- TOC entry 5280 (class 2606 OID 25611)
-- Name: wishlistitems wishlistitems_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wishlistitems
    ADD CONSTRAINT wishlistitems_productid_fkey FOREIGN KEY (productid) REFERENCES public.products(productid) ON DELETE CASCADE;


--
-- TOC entry 5281 (class 2606 OID 25606)
-- Name: wishlistitems wishlistitems_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wishlistitems
    ADD CONSTRAINT wishlistitems_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


-- Completed on 2026-07-19 22:16:40

--
-- PostgreSQL database dump complete
--

\unrestrict 1zG4MIpSfYK2CoquO6xqtgbhDubA5pLsMcInuILFtUnn8amk6JkpGc0GcSpwoEG

