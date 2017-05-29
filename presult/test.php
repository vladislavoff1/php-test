<?php
require_once "DbSimple-master/lib/DbSimple/Generic.php";


interface i_model
{
	public function __construct($id = null);
	public function set_field($field, $value);
	public function get_field($field);
	public function save();
	public function delete();
	public function id();
}

abstract class model implements i_model
{
	//	...

    public function __construct($id = null)
    {

    }

    public function set_field($field, $value)
    {
        $arr = [];
        $arr[0] = $field;
        $arr[1] = $value;
        return $arr;
    }

    public function get_field($field)
    {
     return $this->field = $field;

    }

    public function save()
    {

    }

    public function delete()
    {


    }

    public function id()
    {

    }
}

class blog_post extends model
{
	//	....
    public function connect()
        // Подключение БД
    {
        $db = DbSimple_Generic::connect("mysql://root:@localhost/test_1");
        return $db;
    }

    function get_field($field) {
        // Получение поля из таблицы БД
        $field_1 = parent::get_field($field);
        $db = $this->connect();
        $data = $db->selectCol('SELECT ?# FROM blog_post', $field_1);
        print_r($data);
    }

    function set_field($field, $value) {
        // Добавление поля в таблицу БД
        $arr = parent::set_field($field, $value);
        $field_1 = $arr[0];
        $value_1 = $arr[1];

        $db = $this->connect();
        $db->query('INSERT INTO blog_post (?#) VALUE (?)', $field_1, $value_1);
    }


}


$post_1 = new blog_post(1);
$post_2 = new blog_post(2);

echo $post_2->get_field('date');
echo $post_1->get_field('text');

$post_1->delete();
$post_2->set_field('name', 'Some new name');
$post_2->save();


$post_3 = new blog_post();
$post_3->set_field('name', 'Test');
$post_3->set_field('text', 'Test text');
$post_3->save();
echo $post_3->id();



// blog_topic
/*
$topic = new blog_topic(1);
echo $post_3->set_field('name');
*/